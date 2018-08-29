FactoryBot.define do
  factory :advertiser do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    phone '078855'
    address 'walla walla'
    avatar 'assets/sd.png'
    email 'advertiser@gmail.com'
    password 'advertiser'
  end
end
