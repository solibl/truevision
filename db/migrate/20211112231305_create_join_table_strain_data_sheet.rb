class CreateJoinTableStrainDataSheet < ActiveRecord::Migration[6.0]
  def change
    create_join_table :data_sheets, :strains do |t|
      t.references :root_rating, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :initial_dry_back
      t.integer :total_clone_count
      t.integer :average_gram_difference
      t.timestamps
    end
  end
end
