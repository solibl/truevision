class AddTotalNumberOfRacksToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :total_rack, :integer
  end
end
