FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room

    trait :with_images do
      transient do
        image_count { 3 } # 生成する画像の数を調整できます
      end

      after(:build) do |message, evaluator|
        evaluator.image_count.times do
          message.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
        end
      end
    end
  end
end