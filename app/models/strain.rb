class Strain < ApplicationRecord
	has_many :data_sheets, through :strain_data_sheets
end
