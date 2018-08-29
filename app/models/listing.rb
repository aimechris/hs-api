class Listing < ApplicationRecord
  # Association
  has_and_belongs_to_many :features
  has_many :listimages, inverse_of: :listing
  # Validations
  validates_presence_of :address, :zip_code, :city, :state, :bed, :bath, :sqft, :property_type, :built_year, :sale_type, :price, :title, :description, :display_img, :created_by
  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :listimages

  scope :salestype, ->(sale_type) { where(sale_type: sale_type ) }
  scope :location, -> (location) { where(city: location ) }
  scope :min_price, ->(min_price) { where("price < ?", min_price) if min_price.present? }
  scope :max_price, ->(max_price) { where("price > ?", max_price) if max_price.present? }
  scope :bed, -> (bed) { where(bed: bed ) }
  scope :bath, -> (bath) { where(bath: bath ) }
  scope :propertytype, -> (property_type) { where(property_type: property_type ) }

end
