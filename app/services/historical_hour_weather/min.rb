module HistoricalHourWeather
  class Min < HistoricalHourWeather::Base

    class << self
      def call
        record = find_last_day_min_temperature
        HourWeathersSerializer.render_as_json(record, view: :base)
      end

      private

      def find_last_day_min_temperature
        scope = get_last_day_scope
        scope.order(:temperature_value).limit(1).first
      end
    end
  end
end