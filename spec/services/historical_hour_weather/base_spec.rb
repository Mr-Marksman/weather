require 'rails_helper'

RSpec.describe HistoricalHourWeather::Base do
  describe '.get_last_day_scope' do
    let!(:old_hour_weathers) { FactoryBot.create_list(:old_hour_weather, 10) }
    subject { described_class.send(:get_last_day_scope) }

    context 'with existing hour weathers for the last day' do
      let!(:hour_weathers) { FactoryBot.create_list(:hour_weather, 10) }

      it 'returns the scope with hour weathers for the last day' do
        expect(subject).to match_array(hour_weathers)
      end
    end

    context 'with no hour weathers for the last day' do
      it 'returns an empty scope' do
        expect(subject).to be_empty
      end
    end
  end
end