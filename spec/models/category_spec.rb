require 'rails_helper'

RSpec.describe Category, type: :model do
  # Associations Test
  it { should have_many (:posts) }
  # Validations Test
  it { should validate_presence_of (:category_name) }
  
end
