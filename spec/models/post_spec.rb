require 'rails_helper'

RSpec.describe Post, type: :model do
  # Associations Test
  it { should belong_to(:category) }
  it { have_and_belong_to_many(:tags) }
  # Validations Test
  it { should validate_presence_of (:title) }
  it { should validate_presence_of (:content) }
  it { should validate_presence_of (:post_image) }
  
end
