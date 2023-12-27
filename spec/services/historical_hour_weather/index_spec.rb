require 'rails_helper'

RSpec.describe HistoricalHourWeather::Index do
  describe '.call' do
    let!(:hour_weathers) { FactoryBot.create_list(:hour_weather, 4) }
    subject { described_class.call }

    before do
      allow(HistoricalHourWeather::Base).to receive(:get_last_day_scope).and_return(hour_weathers)
      allow(HourWeathersSerializer).to receive(:render_as_json).with(hour_weathers, view: :base)
      subject
    end

    it 'calls .get_last_day_scope' do
      expect(HistoricalHourWeather::Base).to have_received(:get_last_day_scope).once
    end

    it 'calls HourWeathersSerializer.render_as_json' do
      expect(HourWeathersSerializer).to have_received(:render_as_json).with(hour_weathers, view: :base).once
    end
  end
end