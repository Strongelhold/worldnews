if Rails.env.development?
  logins = []
  100.times { logins << Faker::Internet.user_name }
  ips = []
  50.times { ips << Faker::Internet.ip_v4_address }

  200_000.times do |index|
    params = {
      title: Faker::Lorem.word,
      content: Faker::Lorem.paragraph,
      login: logins.sample,
      author_ip: ips.sample
    }
    post = CreatePost.new(params).call
    3.times { RatePost.new(post.id, Faker::Number.between(1, 5)).call } if index % 10 == 0
  end
end
