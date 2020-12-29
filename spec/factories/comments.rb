FactoryBot.define do
  factory :comment do
    rate {3}
    text {Faker::Lorem.sentence}
    association :user
    association :toilet
  end
end
