source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 6.0.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.4'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Admin Page
gem 'activeadmin'

#serializers
gem 'active_model_serializers'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'activeresource'
gem 'aws-sdk-s3', require: false
gem 'aws-sdk-sqs'
gem 'aws-sdk-dynamodb'
gem 'bootstrap', '~> 4.3.1'
#Add Trhead Pools
gem 'concurrent-ruby', require: 'concurrent'
#Discord Weebhook
gem 'discordrb-webhooks'
#Add Cors Response
gem 'rack-cors'
#Add Users Auth
gem 'devise'
gem "omniauth", "~> 1.9.1" # Can not move to 2.0 because of devise
gem 'omniauth-shopify-oauth2', '~> 2.2.2'
#Add API validations
gem 'dry-validation'
gem 'dry-monads'
gem 'image_processing', '~> 1.12'
gem 'pry'
gem 'pry-remote'
gem 'pry-nav'
gem 'redis'
gem 'serviceworker-rails'
gem 'shopify_app', '~> 17'
gem 'sidekiq'
gem 'sprockets', '~> 3.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webpush'
#web monitoring tool
gem 'newrelic_rpm'
gem 'barnes'
#Exception Notifier
gem 'rollbar'
#Validate URLs
gem "validate_url"
#Custumer Success App
gem "intercom-rails"
gem 'intercom', '~> 4.1'
# Feature flipping for ruby
gem 'flipper', '~> 0.19'
gem 'flipper-ui', '~> 0.19'
gem 'flipper-redis', '~> 0.19'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "benchmark-memory"
  gem 'rspec-rails', '~> 4.0.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 5.1.1'
  gem "faker"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  #rubocop
  gem 'rubocop', '~> 0.89.1', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'database_cleaner-active_record', '~> 1.8.0'
  gem 'simplecov', require: false
  gem 'shoulda-matchers', require: false
  # Save externa HTTP requests for testing
  gem 'vcr'
  gem 'webmock'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
