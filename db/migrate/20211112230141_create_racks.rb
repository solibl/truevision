class CreateRacks < ActiveRecord::Migration[6.0]
  def change
    create_table :storage_racks do |t|
      t.references :location, foreign_key: true
      t.string :name
      t.boolean :current
      t.timestamps
    end
  end
end
