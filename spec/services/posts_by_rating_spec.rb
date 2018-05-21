require 'rails_helper'

RSpec.describe PostsByRating, type: :service do
  subject { PostsByRating }

  describe '#call' do
    it do
      create_list :post, 10, :with_ratings
      limit = 5

      posts = subject.new(limit).call
      first_post_rating = posts[0].average_rating
      second_post_rating = posts[1].average_rating
      expect(first_post_rating).to be >= second_post_rating
    end
  end
end
