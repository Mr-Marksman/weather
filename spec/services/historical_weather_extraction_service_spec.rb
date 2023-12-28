require 'rails_helper'

RSpec.describe HistoricalWeatherExtractionService do
  describe '.call' do
    let(:first_hash_epoch_time) { 1640124000 }
    let(:first_hash_t_value) { 25.0 }
    let(:second_hash_epoch_time) { 1640127600 }
    let(:second_hash_t_value) { 28.0 }
    let(:api_response) do
      [
        {
          'EpochTime' => first_hash_epoch_time,
          'Temperature' => { 'Metric' => { 'Value' => first_hash_t_value } }
        },
        {
          'EpochTime' => second_hash_epoch_time,
          'Temperature' => { 'Metric' => { 'Value' => second_hash_t_value } }
        }
      ]
    end

    subject { described_class.call }

    before do
      allow(AccuWeatherApiService).to receive(:get).and_return(api_response)
    end

    it 'should perform background job' do
      expect { subject }.to change { Delayed::Job.count }.by(1)
    end

    it 'creates HourWeather records from the API response' do
      Delayed::Worker.delay_jobs = false
      expect { subject }.to change(HourWeather, :count).by(2)
    end

    it 'handles errors and continues processing other records' do
      Delayed::Worker.delay_jobs = false
      allow(HourWeather).to receive(:find_or_create_by).with({ epoch_time: first_hash_epoch_time, temperature_value: first_hash_t_value }).and_raise(ActiveRecord::RecordInvalid.new(nil)).once
      allow(HourWeather).to receive(:find_or_create_by).with({ epoch_time: second_hash_epoch_time, temperature_value: second_hash_t_value }).and_call_original.once
      expect { subject }.to change(HourWeather, :count).by(1)
    end
  end
end
