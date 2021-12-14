class CreateRootRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :root_ratings do |t|
      t.string :name
      t.timestamps
    end
  end
end
