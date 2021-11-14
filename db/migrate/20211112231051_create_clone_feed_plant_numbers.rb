class CreateCloneFeedPlantNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :clone_feed_plant_numbers do |t|
      t.string :number_of_clones
      t.timestamps
    end
  end
end