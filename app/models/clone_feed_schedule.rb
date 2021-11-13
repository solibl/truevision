class CloneFeedSchedule < ApplicationRecord
	belongs_to :clone_feed_plant_number
	belongs_to :clone_feed_day
end
