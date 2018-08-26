class Feature < ApplicationRecord
  # Association
  has_and_belongs_to_many :listings
  # Validations
  validates_presence_of :feature_name
end
