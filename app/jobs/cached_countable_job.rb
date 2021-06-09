class CachedCountableJob < ApplicationJob
  queue_as :default

  def perform()
    redis.del("CachedCountableQueued")

    while (key = redis.spop("CachedCountable")) != nil do
      _class, id, column = key.split("/")
      value = get_value(key)
      _class.constantize.find(id).increment!(column, value.to_i)
    end
  end

  private

  def redis
    @redis ||= Redis.current
  end

  def get_value(key)
    redis.multi
    redis.get(key)
    redis.del(key)
    value, _ = redis.exec

    value
  end
end
