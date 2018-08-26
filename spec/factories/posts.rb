FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    category_id nil
    subtitle { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    post_image { Faker::Lorem.word }
    status { Faker::Lorem.word }
    published_by { Faker::Lorem.word }
    published_at { Faker::Time.between(DateTime.now - 1, DateTime.now) }
  end
end
