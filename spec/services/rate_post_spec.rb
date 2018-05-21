require 'rails_helper'

RSpec.describe RatePost, type: :service do
  subject { RatePost }

  let(:post) { create :post }
  let(:rate) { Faker::Number.between(1, 5) }

  describe '#call' do
    it { expect { subject.new(post.id, rate).call }.to change { Rating.count }.from(0).to(1) }
    it 'associate rating to post' do
      subject.new(post.id, rate).call
      expect(post.ratings.count).to be 1
      expect(post.reload.average_rating).to be rate
    end

    it 'returns average post rating' do
      expect(subject.new(post.id, rate).call).to eq rate
    end

    context 'when rate incorrect' do
      [-2, 0, 7].each do |rate|
        it 'returns error' do
          expect { subject.new(post.id, rate).call }.to raise_error RatingValidationError, RatingValidationError::VALUE
        end
      end
    end

    context 'when post id is nil' do
      it { expect { subject.new(nil, rate).call }.to raise_error RatingValidationError, RatingValidationError::POST_ID }
    end
  end
end
