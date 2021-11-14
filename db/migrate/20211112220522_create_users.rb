class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :location, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :authorization_level
      t.string :initials
      t.timestamps
    end
  end
end
