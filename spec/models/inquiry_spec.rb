require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  # Association Test
  it { should belong_to (:listing) }
  # Validations Test
  it { should validate_presence_of (:querry) }
  it { should validate_presence_of (:created_at) }
end
