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

  private

  def count_cached(method, attribute, by)
    redis_key = key(attribute)
    redis.multi
    redis.send(method, redis_key, by)
    redis.sadd("CachedCountable", redis_key)
    redis.setnx("CachedCountableQueued", 1)
    _, _, queue = redis.exec
    schedule(queue)
  end
  
  def redis
    @redis ||= Redis.current
  end

  def name
    self.class.name
  end

  def key(attribute=:count)
    "#{name}/#{id}/#{attribute}"
  end

  def schedule(queue)
    CachedCountableJob.perform_later(@@cache_time.from_now) unless queue.zero?
  end
end