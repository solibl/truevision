class StrainDataSheet < ApplicationRecord
	belongs_to :data_sheet
	belongs_to :strain
	belongs_to :root_rating
	belongs_to :location
end
