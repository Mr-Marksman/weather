module HistoricalHourWeather
  class Index < HistoricalHourWeather::Base

    class << self
      def call
        scope = get_last_day_scope
        HourWeathersSerializer.render_as_json(scope, view: :base)
      end
    end
  end
end