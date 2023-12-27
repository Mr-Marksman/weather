# spec/controllers/weather/historical/historical_hour_weather_controller_spec.rb

require 'rails_helper'

RSpec.describe Weather::Historical::HistoricalHourWeatherController, type: :controller do
  describe 'GET #index' do
    let(:weather_service) { HistoricalHourWeather::Index }

    before do
      allow(weather_service).to receive(:call).and_return(weather_service_response)
      get :index
    end

    context 'there is any data' do
      let(:weather_service_response) { instance_double(Array) }
      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'there is no any data' do
      let(:weather_service_response) { nil }
      it 'returns 404 code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #max' do
    let(:weather_service) { HistoricalHourWeather::Max }

    before do
      allow(weather_service).to receive(:call).and_return(weather_service_response)
      get :max
    end

    context 'there is any data' do
      let(:weather_service_response) { instance_double(Hash) }

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'there is no any data' do
      let(:weather_service_response) { nil }

      it 'returns 404 code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #min' do
    let(:weather_service) { HistoricalHourWeather::Min }

    before do
      allow(weather_service).to receive(:call).and_return(weather_service_response)
      get :min
    end

    context 'there is any data' do
      let(:weather_service_response) { instance_double(Hash) }

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'there is no any data' do
      let(:weather_service_response) { nil }

      it 'returns 404 code' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET #avg' do
    let(:weather_service) { HistoricalHourWeather::Avg }

    before do
      allow(weather_service).to receive(:call).and_return(weather_service_response)
      get :avg
    end

    context 'there is any data' do
      let(:weather_service_response) { instance_double(Hash) }

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'there is no any data' do
      let(:weather_service_response) { nil }

      it 'returns 404 code' do
        expect(response).to have_http_status(404)
      end
    end
  end
end