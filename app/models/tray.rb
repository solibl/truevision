class Tray < ApplicationRecord
	belongs_to :rack
	belongs_to :location
	has_many :data_sheets
end
