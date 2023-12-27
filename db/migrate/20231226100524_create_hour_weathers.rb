class CreateHourWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :hour_weathers do |t|
      t.float :temperature_value
      t.integer :epoch_time

      t.timestamps
    end
  end
end
