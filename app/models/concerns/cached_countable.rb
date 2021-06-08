module CachedCountable
  extend ActiveSupport::Concern

  def increment(column=:count)
    redis.incr(key(column))
    redis.sadd("CachedCountable", key(column))
    #self.class.increment_counter column, id
  end

  def decrement(column=:count)
    redis.decr(key(column))
    redis.sadd("CachedCountable", key(column))
  end

  private
  
  def redis
    @redis ||= Redis.current
  end

  def name
    self.class.name
  end

  def key(column=:count)
    "#{name}/#{id}/#{column}"
  end
end