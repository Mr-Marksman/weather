require 'rufus-scheduler'
require 'net/http'
require 'json'
require 'rest-client'
require_relative '../../config/environment'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'weather_db',
  username: 'weather',
  password: '123456',
  host: 'localhost'
)

scheduler = Rufus::Scheduler.new

scheduler.cron '18 * * * *' do
  puts 'Running hourly weather extraction job...'
  AccuWeatherApiService.extract_and_create_hourly_weather
  puts 'Hourly weather extraction job complete!'
end

scheduler.join
