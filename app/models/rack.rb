class Rack < ApplicationRecord
	belongs_to :location
	has_many :trays
	has_many :data_sheets
end
