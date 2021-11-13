class CreateTrays < ActiveRecord::Migration[6.0]
  def change
    create_table :trays do |t|
      t.references :rack, foreign_key: true
      t.references :location, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
