class Advertiser < ApplicationRecord
  # encrypt password
  has_secure_password
  # Associations
  has_many :listings, foreign_key: :created_by

  # Validations
  validates_presence_of :first_name, :last_name, :phone, :address, :email, :password
end
