module CurrentWeather
  class Show

    class << self
      def call
        response = AccuWeatherApiService.get(AccuWeatherApiService::API_CURRENT_WEATHER_ENDPOINT)

        record = HourWeather.find_or_create_by(
          epoch_time: response.first['EpochTime'],
          temperature_value: response.first['Temperature']['Metric']['Value']
        )

        HourWeathersSerializer.render_as_json(record, view: :base)
      end
    end
  end
end