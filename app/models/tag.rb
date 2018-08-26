class Tag < ApplicationRecord
  # Association
  has_and_belongs_to_many :posts
  # Validations
  validates_presence_of :tag_name
end
