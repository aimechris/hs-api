require 'rails_helper'

RSpec.describe Author, type: :model do
  # Associations Test
  it { should have_many(:posts) }
  # Validations Test
  it { should validate_presence_of (:author_name) }
  it { should validate_presence_of (:email) }
  it { should validate_presence_of (:password) }

end
