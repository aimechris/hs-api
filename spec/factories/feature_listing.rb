FactoryBot.define do
  factory :listing_with_features do
    transient do
      features_count 5
    end
  end
end
