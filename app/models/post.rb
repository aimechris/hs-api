class Post < ApplicationRecord
  # Associations
  belongs_to :category
  has_and_belongs_to_many :tags
  # Validations
  validates_presence_of :title, :content, :post_image
end
