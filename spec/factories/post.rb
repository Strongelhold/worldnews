FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    author_ip { Faker::Internet.ip_v4_address }
    user

    trait :with_ratings do
      after(:create) do |post|
        create_list :rating, 10, post_id: post.id
      end
    end
  end
end
