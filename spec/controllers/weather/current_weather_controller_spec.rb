RSpec.describe Weather::CurrentWeatherController, type: :controller do
  describe 'GET #show' do
    let(:weather_service) { CurrentWeather::Show }

    before do
      allow(weather_service).to receive(:call).and_return(weather_service_response)
      get :show
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