module Weather
  class CurrentWeatherController < ApplicationController

    def show
      response = CurrentWeather::Show.call
      render_base_response(response)
    end
  end
end