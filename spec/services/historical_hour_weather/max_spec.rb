require 'rails_helper'

RSpec.describe HistoricalHourWeather::Max do
  describe '.call' do
    let!(:max_temperature_hour_weather) { FactoryBot.create(:hour_weather, temperature_value: 25.0) }
    let!(:other_hour_weather) { FactoryBot.create(:hour_weather, temperature_value: 2.0) }
    let(:scope) { HourWeather.where('epoch_time > ?', (Time.now.in_time_zone('Moscow') - 1.day).to_i) }
    subject { described_class.call }

    before do
      allow(HistoricalHourWeather::Base).to receive(:get_last_day_scope).and_return(scope)
      allow(HourWeathersSerializer).to receive(:render_as_json)
      subject
    end

    it 'calls .get_last_day_scope' do
      expect(HistoricalHourWeather::Base).to have_received(:get_last_day_scope).once
    end

    it 'calls HourWeathersSerializer.render_as_json' do
      expect(HourWeathersSerializer).to have_received(:render_as_json).with(max_temperature_hour_weather, view: :base).once
    end
  end

  describe '.find_last_day_max_temperature' do
    subject { described_class.send(:find_last_day_max_temperature) }

    context 'with existing hour weathers for the last day' do
      let!(:hour_weathers) { FactoryBot.create_list(:hour_weather, 5) }
      let(:max_temperature_record) { hour_weathers.max_by(&:temperature_value) }

      it 'returns the record with the maximum temperature for the last day' do
        expect(subject).to eq(max_temperature_record)
      end
    end

    context 'with no hour weathers for the last day' do
      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end