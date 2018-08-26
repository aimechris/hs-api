require 'rails_helper'

RSpec.describe Advertiser, type: :model do
  # Associations Test
  it { should have_many(:listings) }
  # Validations Test
  it { should validate_presence_of (:first_name) }
  it { should validate_presence_of (:last_name) }
  it { should validate_presence_of (:phone) }
  it { should validate_presence_of (:address) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }

end
