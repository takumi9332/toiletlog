FactoryBot.define do
  factory :toilet do
    prefecture_id {2}
    city {"札幌市"}
    address {"札幌1-1-1"}
    building {"札幌ビル"}
    sex_id {1}
    type_id {1}
    washlet_id {1}
    clean_id {1}
    info {Faker::Lorem.sentence}
    association :user

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end