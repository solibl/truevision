class CreateCloneFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :clone_feeds do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :date
      t.decimal :clone_feed_ph, precision: 1, scale: 1
      t.decimal :clone_feed_ec, precision: 1, scale: 1
      t.integer :volume_per_tray
      t.timestamps
    end
  end
end
