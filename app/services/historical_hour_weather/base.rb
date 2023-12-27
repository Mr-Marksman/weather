module HistoricalHourWeather
  class Base

    class << self
      protected

      def get_last_day_scope
        HourWeather.where('epoch_time > ?', (Time.now.in_time_zone('Moscow') - 1.day).to_i)
      end
    end
  end
end