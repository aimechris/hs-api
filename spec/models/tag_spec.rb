require 'rails_helper'

RSpec.describe Tag, type: :model do
  # Association Test
  it { should have_and_belong_to_many(:posts) }
  # Validations Test
  it { should validate_presence_of(:tag_name) }
end
