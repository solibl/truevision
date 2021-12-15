class DataSheet < ApplicationRecord
  belongs_to :storage_rack
  belongs_to :tray
  belongs_to :location
  belongs_to :strain
  has_many :data_entries
  attr_accessor :note
end
