FactoryBot.define do
  factory :inquiry do
    querry { Faker::Lorem.paragraph }
    listing_id nil
    created_at { Faker::Datetime.date }
  end
end
