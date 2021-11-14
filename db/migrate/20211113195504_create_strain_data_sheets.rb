class CreateStrainDataSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :strain_data_sheets do |t|
      t.references :strain, foreign_key: true
      t.references :data_sheet, foreign_key: true
      t.references :root_rating, foreign_key: true
      t.references :location, foreign_key: true
      t.integer :initial_dry_back
      t.integer :total_clone_count
      t.integer :average_gram_difference
      t.timestamps
    end
  end
end
