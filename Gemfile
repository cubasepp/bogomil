# frozen_string_literal: true

source "https://rubygems.org"

ruby file: ".ruby-version"

gem "rails"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "jbuilder"
gem "propshaft"
gem "puma"
gem "sqlite3"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "simple_form"
gem "solid_queue"
gem "excon"
gem "csv"
gem "solid_cable"
gem "importmap-rails"

gem "tzinfo-data", platforms: [:windows, :jruby]

group :test do
  gem "webmock"
end

group :development, :test do
  gem "debug", platforms: [:mri, :windows]
  gem "dotenv"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 8"
  gem "rubocop-rails", require: false
  gem "rubocop-shopify", require: false
  gem "shoulda-matchers", "~> 6"
end

group :development do
  gem "web-console"
end
