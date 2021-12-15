class CreateDataEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :data_entries do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.references :data_sheet, foreign_key: true
      t.datetime :date
      t.integer :day_count
      t.string :shift
      t.integer :weight
      t.integer :gram_difference
      t.string :fed
      t.decimal :clone_feed_ph
      t.decimal :clone_feed_ec
      t.integer :weight_after_feed
      t.boolean :has_hood, default: true
      t.boolean :grown_roots, default: false
      t.boolean :marked_for_outlier, default: false
      t.integer :number_of_plants_killed
      t.text :note
      t.string :edited_user_initials
      t.timestamps
    end
  end
end
