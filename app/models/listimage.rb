class Listimage < ApplicationRecord
  # Associations
  belongs_to :listing
  # Validations
  validates_presence_of :photo
end
