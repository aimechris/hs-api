class Inquiry < ApplicationRecord
  # Associations
  belongs_to :listing
  # Validations
  validates_presence_of :querry, :created_at
end
