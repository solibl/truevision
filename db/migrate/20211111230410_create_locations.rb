class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :trays_per_storage_row
      t.integer :entry_per_day
      t.timestamps
    end
  end
end
