FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    author_ip { Faker::Internet.ip_v4_address }
    user

    before(:create) do |post|
      post.user_login = post.user.login
    end

    trait :with_ratings do
      after(:create) do |post|
        create_list :rating, 10, post_id: post.id
        post.average_rating = post.ratings.pluck(:value).sum / post.ratings.count
        post.save
      end
    end
  end
end
