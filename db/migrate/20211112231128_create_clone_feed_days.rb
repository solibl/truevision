class CreateCloneFeedDays < ActiveRecord::Migration[6.0]
  def change
    create_table :clone_feed_days do |t|
      t.integer :clone_feed_day
      t.timestamps
    end
  end
end
