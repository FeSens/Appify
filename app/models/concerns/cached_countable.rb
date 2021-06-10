module CachedCountable
  extend ActiveSupport::Concern

  @@cache_time = 1.minute

  included do
    def self.cache_time(value)
      @@cache_time = value
    end

    def self.increment_cached(attribute, id, by=1)
      self.count_cached(:incrby, attribute, by, id)
    end
  
    def self.decrement_cached(attribute, id, by=1)
      self.count_cached(:decrby, attribute, by, id)
    end

    private

    def self.count_cached(method, attribute, by, id)
      redis_key = self.key(attribute, id)
      _, _, queue = self.redis.multi do |multi|
        multi.send(method, redis_key, by)
        multi.sadd("CachedCountable", redis_key)
        multi.set("CachedCountableQueued", 1, ex: @@cache_time + 2, nx: true)
      end
  
      schedule if queue
    end
    
    def self.redis
      @@redis ||= Redis.current
    end
  
    def self.key(attribute, id)
      "#{name}/#{id}/#{attribute}"
    end
  
    def self.schedule
      CachedCountableJob.set(wait_until: @@cache_time.from_now).perform_later
    end
  end

  def increment(attribute, by=1)
    self.class.count_cached(:incrby, attribute, by, id)
  end

  def decrement(attribute, by=1)
    self.class.count_cached(:decrby, attribute, by, id)
  end

  def increment!(attribute, by=1)
    self[attribute] ||= 0
    self[attribute] += by
    self.update_attribute(attribute, self[attribute])
  end

  def decrement!(attribute, by=1)
    self[attribute] ||= 0
    self[attribute] -= by
    self.update_attribute(attribute, self[attribute])
  end

  def is_cached?(attribute)
    self.class.redis.get(self.class.key(attribute, id)).present?
  end

  def get_current_value(attribute)
    self[attribute] + self.class.redis.get(self.class.key(attribute, id)).to_i
  end
end