require 'rails_helper'

RSpec.describe Feature, type: :model do
  # Association Test
  it { should have_and_belong_to_many(:listings) }
  # Validation Test
  it { should validate_presence_of(:feature_name) }
end
