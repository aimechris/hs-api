FactoryBot.define do
  factory :listimage do
    image { Faker::Lorem.word }
    listing_id nil
  end
end
