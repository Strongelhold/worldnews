require 'rails_helper'

RSpec.describe CalculateAveragePostRating, type: :service do
  subject { CalculateAveragePostRating }

  let(:post) { create :post, :with_ratings }

  describe '#call' do
    it 'returns average rating' do
      control_sample = post.ratings.pluck(:value).sum / post.ratings.count
      expect(subject.new(post.id).call).to eq control_sample
    end

    context 'when ratings are empty' do
      it 'returns 0' do
        post = create :post
        expect(subject.new(post.id).call).to eq 0
      end
    end
  end
end
