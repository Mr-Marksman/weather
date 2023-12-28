module HistoricalHourWeather
  class Avg < HistoricalHourWeather::Base
    class << self

      def call
        responce_hash = find_last_day_avg_temperature
        responce_hash
      end

      private

      def find_last_day_avg_temperature
        scope = get_last_day_scope
        { avg_temperature: calculate_avg_temperature(scope) }
      end

      def calculate_avg_temperature(scope)
        scope.any? ? (scope.pluck(:temperature_value).sum / scope.count).round(1) : nil
      end
    end
  end
end