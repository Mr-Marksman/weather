module Weather
  class ByTimeWeatherController < ApplicationController

    def show
      epoch_time = params.require(:epoch_time).to_i
      response = epoch_time.present? ? ByTimeWeather::Show.call(epoch_time) : nil

      render_base_response(response)
    end
  end
end