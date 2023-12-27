# spec/services/by_time_weather/show_spec.rb

require 'rails_helper'

RSpec.describe ByTimeWeather::Show do
  describe '.call' do
    let(:current_time) { Time.now.in_time_zone('Moscow') }
    let(:half_hour_ago) { current_time - 30.minutes }
    let(:half_hour_later) { current_time + 30.minutes }
    let(:two_hours_later) { current_time + 2.hours }
    subject { described_class.call(epoch_time) }

    context 'epoch_time is in historical weather range' do
      let(:epoch_time) { current_time.to_i }
      let!(:hour_weather) { FactoryBot.create(:hour_weather, epoch_time: current_time.to_i - 15.minutes.to_i) }
      let!(:old_hour_weather) { FactoryBot.create(:old_hour_weather) }
      let(:service_responce) {
        {
          type: 'historical',
          epoch_time: hour_weather.epoch_time,
          temperature_value: hour_weather.temperature_value
        }
      }

      before do
        allow(AccuWeatherApiService).to receive(:get)
      end

      it 'returns historical weather correct data' do
        expect(subject).to eq(service_responce)
      end

      it 'Do not call AccuWeatherApiService' do
        expect(AccuWeatherApiService).to_not have_received(:get)
      end
    end

    context 'epoch_time is in future weather range' do
      let(:epoch_time) { (current_time + 1.hour).to_i }
      let!(:hour_weather) { FactoryBot.create(:hour_weather, epoch_time: current_time.to_i - 15.minutes.to_i) }
      let(:half_hour_hash_api_response) { { 'EpochDateTime' => half_hour_later.to_i, 'Temperature' => { 'Value' => 25.0 } } }
      let(:two_hours_hash_api_response) { { 'EpochDateTime' => two_hours_later.to_i, 'Temperature' => { 'Value' => 29.0 } } }
      let(:api_response) { [half_hour_hash_api_response, two_hours_hash_api_response] }
      let(:service_responce) {
        {
          type: 'forecast',
          epoch_time: half_hour_hash_api_response['EpochDateTime'],
          temperature_value: half_hour_hash_api_response['Temperature']['Value']
        }
      }

      before do
        allow(AccuWeatherApiService).to receive(:get).and_return(api_response)
      end

      it 'returns forecast weather data' do
        expect(subject).to eq(service_responce)
      end

      it 'calls AccuWeatherApiService' do
        subject
        expect(AccuWeatherApiService).to have_received(:get).once
      end
    end

    context 'epoch_time is not in historical or future weather range' do
      let!(:hour_weather) { FactoryBot.create(:hour_weather, epoch_time: current_time.to_i - 15.minutes.to_i) }
      let!(:old_hour_weather) { FactoryBot.create(:old_hour_weather) }

      context 'when less than smallest available time' do
        let(:epoch_time) { (old_hour_weather.epoch_time - 1.hour).to_i }

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end

      context 'when bigger than biggest available time' do
        let(:epoch_time) { (current_time + 2.days).to_i }

        it 'returns nil' do
          expect(subject).to be_nil
        end
      end
    end
  end
end