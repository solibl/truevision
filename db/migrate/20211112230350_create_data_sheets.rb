class CreateDataSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :data_sheets do |t|
      t.references :storage_rack, foreign_key: true
      t.references :tray, foreign_key: true
      t.references :location, foreign_key: true
      t.references :strain, foreign_key: true
      t.references :root_rating, foreign_key: true
      t.boolean :current, default: true
      t.string :status
      t.integer :starting_total_clone_number
      t.integer :initial_soak_weight
      t.integer :total_clone_count
      t.integer :ending_clone_total_number
      t.integer :first_initial_dry_back
      t.integer :first_initial_dry_back_day_count
      t.integer :average_gram_difference
      t.integer :first_day_roots
      t.decimal :success_rate
      t.boolean :marked_for_outlier, default: false  
      t.timestamps
    end
  end
end
