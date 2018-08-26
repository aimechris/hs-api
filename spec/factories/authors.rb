FactoryBot.define do
  factory :author do
    author_name { Faker::Name.name }
    email 'foo@bar.com'
    password 'foobar'
  end
end
