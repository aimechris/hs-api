FactoryBot.define do
  factory :listing do
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city_prefix }
    state { Faker::Address.state }
    bed { Faker::Number.number(10) }
    bath { Faker::Number.number(10) }
    sqft { Faker::Number.number(10) }
    property_type { Faker::Lorem.word }
    built_year { Faker::Number.number(10) }
    sale_type { Faker::Lorem.word }
    price { Faker::Number.decimal_part(2) }
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    virtual_tour { Faker::Lorem.word }
    display_img { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
