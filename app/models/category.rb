class Category < ApplicationRecord
  # Associations
  has_many :posts
  # Validations
  validates_presence_of :category_name
end
