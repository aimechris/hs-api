FactoryBot.define do
  factory :feature do
    feature_name { Faker::Lorem.word }
  end
end
