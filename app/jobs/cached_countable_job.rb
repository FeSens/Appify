class CachedCountableJob < ApplicationJob
  queue_as :default

  def perform()
    while (key = redis.spop("CachedCountable")) != nil) do
      _class, id, column = key.split("/")
      value = get_value(key)
      _class.constantize.find(id).increment!(column, value)
    end
  end

  private

  def redis
    @redis ||= Redis.current
  end

  def get_value(key)
   value = redis.get(key)
   redis.del(key)

   value
  end
end
