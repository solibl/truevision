class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :location, foreign_key: true
      t.string :name
      t.string :authorization_level
      t.timestamps
    end
  end
end
