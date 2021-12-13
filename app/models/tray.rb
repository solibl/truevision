class Tray < ApplicationRecord
	belongs_to :storage_rack
	belongs_to :location
	has_many :data_sheets
end
