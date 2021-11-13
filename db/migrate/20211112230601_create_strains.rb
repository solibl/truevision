class CreateStrains < ActiveRecord::Migration[6.0]
  def change
    create_table :strains do |t|
      t.string :name
      t.integer :best_average_initial_dryback
      t.integer :best_average_gram_difference
      t.timestamps
    end
  end
end
