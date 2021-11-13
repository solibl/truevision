class AddHoodDaysToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :total_hood_days, :integer
  end
end
