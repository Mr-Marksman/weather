# spec/services/current_weather/show_spec.rb

require 'rails_helper'

RSpec.describe CurrentWeather::Show do
  describe '.call' do
    let(:api_response) do
      [
        {
          'EpochTime' => Time.now.to_i,
          'Temperature' => { 'Metric' => { 'Value' => 25.0 } }
        }
      ]
    end
    let(:hour_weather) { FactoryBot.create(:hour_weather) }
    subject { described_class.call }

    before do
      allow(AccuWeatherApiService).to receive(:get).and_return(api_response)
    end

    it 'calls AccuWeatherApiService.get' do
      expect(AccuWeatherApiService).to receive(:get).with(AccuWeatherApiService::API_CURRENT_WEATHER_ENDPOINT)
      subject
    end

    it 'finds or creates a record in HourWeather' do
      subject
      expect(HourWeather.count).to be(1)
    end

    it 'renders the record as JSON using HourWeathersSerializer' do
      allow(HourWeather).to receive(:find_or_create_by).and_return(hour_weather)
      expect(HourWeathersSerializer).to receive(:render_as_json).with(
        hour_weather,
        view: :base
      )
      subject
    end
  end
end