class Listing < ApplicationRecord
  # Association
  has_and_belongs_to_many :features
  has_many :listimages, inverse_of: :listing
  # Validations
  validates_presence_of :address, :zip_code, :city, :state, :bed, :bath, :sqft, :property_type, :built_year, :sale_type, :price, :title, :description, :display_img, :created_by
  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :listimages
end
