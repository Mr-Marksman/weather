require 'rails_helper'

RSpec.describe HistoricalHourWeather::Avg do
  describe '.call' do
    let!(:old_hour_weathers) { FactoryBot.create_list(:old_hour_weather, 10) }
    subject { described_class.call }

    context 'with hour weathers for the last day' do
      let!(:hour_weathers) { FactoryBot.create_list(:hour_weather, 10) }
      let(:avg_temperature) { hour_weathers.sum(&:temperature_value) / hour_weathers.count }

      before do
        allow(HistoricalHourWeather::Base).to receive(:get_last_day_scope).and_return(hour_weathers)
      end

      it 'returns the average temperature for the last day' do
        expect(subject).to eq({ avg_temperature: avg_temperature })
      end
    end

    context 'with no hour weathers for the last day' do
      let(:hash_with_nil_param) { { avg_temperature: nil } }

      before do
        allow(HistoricalHourWeather::Base).to receive(:get_last_day_scope).and_return([])
      end

      it 'returns nil param' do
        expect(subject).to eq(hash_with_nil_param)
      end
    end
  end
end