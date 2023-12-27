module ByTimeWeather
  class Show
    HALF_HOUR_TO_EPOCH = 30.minutes.to_i
    HISTORICAL_TYPE = 'historical'
    FORECAST_TYPE = 'forecast'

    class << self
      def call(epoch_time)
        @scope = HourWeather.order(:epoch_time)
        @epoch_time = epoch_time
        @biggest_db_epoch_time = @scope.last.epoch_time
        @smallest_db_epoch_time = @scope.first.epoch_time

        case
        when epoch_time_in_historical_weather_range?
          process_for_historical_weather
        when epoch_time_in_future_weather_range?
          process_for_future_weather
        else
          nil
        end
      end

      private

      def process_for_future_weather
        response = AccuWeatherApiService.get(AccuWeatherApiService::API_FORECAST_URL, metric: true)
        nearest_response_hash = response.min_by { |hash| (hash['EpochDateTime'] - @epoch_time).abs  }

        {
          epoch_time: nearest_response_hash['EpochDateTime'],
          temperature_value: nearest_response_hash['Temperature']['Value'],
          type: FORECAST_TYPE
        }
      end

      def process_for_historical_weather
        nearest_record = HourWeather.order(Arel.sql("ABS(epoch_time - #{@epoch_time})")).first
        {
          epoch_time: nearest_record.epoch_time,
          temperature_value: nearest_record.temperature_value,
          type: HISTORICAL_TYPE
        }
      end

      def epoch_time_in_historical_weather_range?
        @epoch_time.in?(@smallest_db_epoch_time - HALF_HOUR_TO_EPOCH..@biggest_db_epoch_time + HALF_HOUR_TO_EPOCH)
      end

      def epoch_time_in_future_weather_range?
        @epoch_time >= @biggest_db_epoch_time + HALF_HOUR_TO_EPOCH &&
          @epoch_time < ((Time.now.in_time_zone('Moscow') + 12.hours).to_i + HALF_HOUR_TO_EPOCH)
      end
    end
  end
end
