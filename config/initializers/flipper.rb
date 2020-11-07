Flipper.configure do |config|
  config.default do
    redis = Redis.current
    adapter = Flipper::Adapters::Redis.new(redis)

    Flipper.new(adapter)
  end
end

Flipper::UI.configure do |config|
  config.banner_text = "Environment: #{Rails.env}"
  config.banner_class = 'danger'
end