require 'rufus-scheduler'
require 'net/http'
require 'json'
require 'rest-client'
require_relative '../../app/services/accu_weather_api_service'
require_relative '../../app/services/historical_weather_extraction_service'
require_relative '../../config/environment'
require_relative '../../app/models/application_record'
require_relative '../../app/models/hour_weather'

scheduler = Rufus::Scheduler.new

scheduler.cron '10 * * * *' do
  puts 'Running hourly weather extraction job...'
  HistoricalWeatherExtractionService.call
  puts 'Hourly weather extraction job complete!'
end
