class CreateTrays < ActiveRecord::Migration[6.0]
  def change
    create_table :trays do |t|
      t.references :storage_rack, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.boolean :current
      t.timestamps
    end
  end
end
