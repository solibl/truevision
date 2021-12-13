class DataSheet < ApplicationRecord
	belongs_to :storage_rack
	belongs_to :tray
	belongs_to :location
	has_many :data_entries
	has_many :strains, through: :strain_data_sheets
end
