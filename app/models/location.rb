class Location < ApplicationRecord
  has_many :users
  has_many :trays
  has_many :storage_racks
  has_many :data_sheets
  has_many :strain_data_sheets
  has_many :clone_feeds


end
