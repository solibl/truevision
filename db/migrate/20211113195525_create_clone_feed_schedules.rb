class CreateCloneFeedSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :clone_feed_schedules do |t|

      t.timestamps
    end
  end
end
