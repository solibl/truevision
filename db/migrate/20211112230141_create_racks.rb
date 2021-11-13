class CreateRacks < ActiveRecord::Migration[6.0]
  def change
    create_table :racks do |t|
      t.references :location, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
