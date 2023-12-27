require 'net/http'
require 'uri'

class AccuWeatherApiService
  CITY_CODE = '294021'.freeze
  API_BASE_HISTORICAL_URL = 'http://dataservice.accuweather.com/currentconditions/v1/'
  API_FORECAST_URL = 'http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/' + CITY_CODE
  API_HISTORICAL_ENDPOINT = API_BASE_HISTORICAL_URL + CITY_CODE + "/historical/24"
  API_CURRENT_WEATHER_ENDPOINT = API_BASE_HISTORICAL_URL + CITY_CODE

  class << self

    def get(endpoint, params_ext = {})
      params = { 'apikey' => Rails.application.credentials.accu_weather['apikey'] }.merge(params_ext)
      response = RestClient.get(endpoint, params: params)

      if response.code == 200
        return parse(response)
      else
        put_error(response)
        raise
      end
    end

    private

    def put_error(response)
      puts response.code
      puts parse(response)['fault']['faultstring']
    end

    def parse(response)
      JSON.parse(response.body)
    end
  end
end
