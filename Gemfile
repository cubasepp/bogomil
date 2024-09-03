# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.0"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "importmap-rails"
gem "jbuilder"
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.3"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.7"
gem "turbo-rails"
gem "simple_form"
gem "solid_queue"
gem "excon"
gem "tzinfo-data", platforms: [:windows, :jruby]

group :test do
  gem "webmock"
end

group :development, :test do
  gem "debug", platforms: [:mri, :windows]
  gem "dotenv"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
  gem "shoulda-matchers", "~> 6.0"
end

group :development do
  gem "web-console"
end
