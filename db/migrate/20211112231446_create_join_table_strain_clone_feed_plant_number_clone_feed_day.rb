class CreateJoinTableStrainCloneFeedPlantNumberCloneFeedDay < ActiveRecord::Migration[6.0]
  def change
    create_join_table :clone_feed_plant_numbers, :clone_feed_days do |t|
      t.references :clone_feed_plant_number, foreign_key: true
      t.references :clone_feed_day, foreign_key: true
      t.integer :minimum_feed_weight
      t.timestamps
    end
  end
end
