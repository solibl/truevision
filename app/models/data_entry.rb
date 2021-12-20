class DataEntry < ApplicationRecord
  belongs_to :user
  belongs_to :data_sheet
end
