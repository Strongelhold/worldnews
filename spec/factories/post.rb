FactoryBot.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
    author_ip { Faker::Internet.ip_v4_address }
    user
  end
end
