class HistoricalWeatherExtractionService
  class << self
    def call
      response = AccuWeatherApiService.get(AccuWeatherApiService::API_HISTORICAL_ENDPOINT)

      response.each do |weather_record_data|
        HourWeather.find_or_create_by(
          epoch_time: weather_record_data['EpochTime'],
          temperature_value: weather_record_data['Temperature']['Metric']['Value']
        )
      rescue => e
        puts e
      end
    end
  end
end