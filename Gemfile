source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 7.0.5"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "blueprinter"
gem 'rufus-scheduler'
gem 'rest-client'
gem "bootsnap", require: false
gem 'pg'
gem "rspec-rails"
gem 'delayed_job', "> 3"
gem 'delayed_job_active_record'
gem 'daemons'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "byebug"
  gem 'factory_bot_rails'
  gem 'faker'
  gem "rspec-rails"
  gem 'webmock'
  gem 'rswag-api'
  gem 'rswag-ui'
  gem 'rswag-specs'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
