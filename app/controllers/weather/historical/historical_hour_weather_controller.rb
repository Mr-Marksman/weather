module Weather
  module Historical
    class HistoricalHourWeatherController < ApplicationController

      def index
        response = HistoricalHourWeather::Index.call
        render_base_response(response)
      end

      def max
        response = HistoricalHourWeather::Max.call
        render_base_response(response)
      end

      def min
        response = HistoricalHourWeather::Min.call
        render_base_response(response)
      end

      def avg
        response = HistoricalHourWeather::Avg.call
        render_base_response(response)
      end
    end
  end
end