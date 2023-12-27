require 'rails_helper'

RSpec.describe Weather::ByTimeWeatherController, type: :controller do
  describe 'GET #show' do
    let(:weather_service) { ByTimeWeather::Show }

    context 'user try to get weather by time with epoch_time parameter' do
      before do
        allow(weather_service).to receive(:call).with(epoch_time).and_return(weather_service_response)
        get :show, params: { epoch_time: epoch_time }
      end

      context 'with valid epoch_time' do
        let(:epoch_time) { Time.now.to_i }
        let(:weather_service_response) { instance_double(Hash) }

        it 'returns a successful response' do
          expect(response).to be_successful
        end
      end

      context 'with invalid epoch_time' do
        let(:epoch_time) { 0 }
        let(:weather_service_response) { nil }

        it 'returns a bad request response' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when epoch_time param is a string' do
      let(:epoch_time) { 'Some dangerous sql code' }
      let(:weather_service_response) { instance_double(Hash) }

      it 'converts epoch_time to integer' do
        allow(ByTimeWeather::Show).to receive(:call)
        get :show, params: { epoch_time: epoch_time }
        expect(ByTimeWeather::Show).to have_received(:call).with(0)
      end
    end

    context 'user try to get weather by time without epoch_time parameter' do
      before do
        allow(weather_service).to receive(:call).and_return(weather_service_response)
        get :show

        it 'returns a bad request response' do
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end