FactoryBot.define do
  factory :inquiry do
    querry { Faker::Lorem.paragraph }
    listing_id nil
    created_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
end
