require 'rails_helper'

RSpec.describe HourWeathersSerializer, type: :serializer do
  describe 'base view' do
    let(:hour_weather) { FactoryBot.create(:hour_weather) }
    let(:serialized_hour_weather) { described_class.render_as_json(hour_weather, view: :base) }

    it 'correctly serializes the hour weather object' do
      expect(serialized_hour_weather).to eq({
                                              'id' => hour_weather.id,
                                              'temperature_value' => hour_weather.temperature_value,
                                              'epoch_time' => hour_weather.epoch_time
                                            })
    end
  end
end