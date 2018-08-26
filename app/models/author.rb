class Author < ApplicationRecord
  # Encrypt password
  has_secure_password
  # Associations
  has_many :posts, foreign_key: :published_by
  # Validations
  validates_presence_of :author_name, :email, :password
end
