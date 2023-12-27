FactoryBot.define do
  factory :hour_weather do
    temperature_value { Faker::Number.decimal(l_digits: 2) }
    epoch_time { Faker::Time.between(from: 1.days.ago.in_time_zone('Moscow'), to: Time.now.in_time_zone('Moscow')) }
  end

  factory :old_hour_weather, class: 'HourWeather' do
    temperature_value { Faker::Number.decimal(l_digits: 2) }
    epoch_time { Faker::Time.between(from: 3.days.ago.in_time_zone('Moscow'), to: 2.days.ago) }
  end
end