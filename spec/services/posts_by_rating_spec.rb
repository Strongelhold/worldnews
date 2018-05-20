require 'rails_helper'

RSpec.describe PostsByRating, type: :service do
  subject { PostsByRating }

  let!(:posts) { create_list :post, 10, :with_ratings }
  let(:limit) { 5 }

  describe '#call' do
    it do
      posts = subject.new(limit).call
      first_post_rating = posts[0].ratings.average(:value)
      second_post_rating = posts[1].ratings.average(:value)
      expect(first_post_rating).to be >= second_post_rating
    end
  end
end
