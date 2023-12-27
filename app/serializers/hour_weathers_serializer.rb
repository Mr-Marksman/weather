class HourWeathersSerializer < Blueprinter::Base
  identifier :id

  view :base do
    field :temperature_value
    field :epoch_time
  end
end