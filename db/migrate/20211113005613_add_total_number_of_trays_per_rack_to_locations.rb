class AddTotalNumberOfTraysPerRackToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :total_tray_per_rack, :integer
  end
end
