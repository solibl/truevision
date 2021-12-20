class CreateCloneFeedSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :clone_feed_schedules do |t|
      t.integer :clone_feed_plant_number
      t.integer :clone_feed_day
      t.integer :minimum_feed_weight
      t.timestamps
    end
  end
end
