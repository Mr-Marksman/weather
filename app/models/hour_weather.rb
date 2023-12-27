class HourWeather < ApplicationRecord
  validates :temperature_value, :epoch_time, presence: true
  validates :epoch_time, uniqueness: true
end
