class AddCloneFeedPhRootToCloneFeeds < ActiveRecord::Migration[7.0]
  def change
    add_column :clone_feeds, :clone_feed_ph_roots, :decimal, precision: 10, scale: 2
  end
end
