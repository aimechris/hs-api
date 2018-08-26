require 'rails_helper'

RSpec.describe Listimage, type: :model do
  # Association Test
  it { should belong_to(:listing) }
  # Validation Test
  it { should validate_presence_of(:photo) }
end
