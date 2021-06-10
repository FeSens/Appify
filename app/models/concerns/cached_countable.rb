module CachedCountable
  extend ActiveSupport::Concern

  @@cache_time = 1.minute

  included do
    def self.cache_time(value)
      @@cache_time = value
    end
  end

  def increment(attribute, by=1)
    count_cached(:incrby, attribute, by)
  end

  def decrement(attribute, by=1)
    count_cached(:decrby, attribute, by)
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
    redis.get(key(attribute)).present?
  end

  def get_current_value(attribute)
    self[attribute] + redis.get(key(attribute)).to_i
  end

  private

  def count_cached(method, attribute, by)
    redis_key = key(attribute)
    _, _, queue = redis.multi do |multi|
      redis.send(method, redis_key, by)
      redis.sadd("CachedCountable", redis_key)
      redis.setnx("CachedCountableQueued", 1)
    end

    schedule if queue
  end
  
  def redis
    @redis ||= Redis.current
  end

  def class_name
    self.class.name
  end

  def key(attribute=:count)
    "#{class_name}/#{id}/#{attribute}"
  end

  def schedule
    CachedCountableJob.set(wait_until: @@cache_time.from_now).perform_later
  end
end