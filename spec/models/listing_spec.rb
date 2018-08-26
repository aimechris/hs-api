require 'rails_helper'

RSpec.describe Listing, type: :model do
  # Association Test
  it { should have_and_belong_to_many(:features) }
  it { should have_many(:listimages) }
  it { should accept_nested_attributes_for(:features) }
  it { should accept_nested_attributes_for(:listimages) }
  # Validation Test
  it { should validate_presence_of (:address) }
  it { should validate_presence_of (:zip_code) }
  it { should validate_presence_of (:city) }
  it { should validate_presence_of (:state) }
  it { should validate_presence_of (:bed) }
  it { should validate_presence_of (:bath) }
  it { should validate_presence_of (:sqft) }
  it { should validate_presence_of (:property_type) }
  it { should validate_presence_of (:built_year) }
  it { should validate_presence_of (:sale_type) }
  it { should validate_presence_of (:price) }
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:description) }
  it { should validate_presence_of (:display_img) }
  it { should validate_presence_of (:created_by) }
  #query Test

end
