class RatePost
  def initialize(post_id, rate)
    @post_id = post_id
    @rate = rate
  end

  def call
    validate_rate_value
    validate_post_id
    create_rating
  end

  private

  attr_reader :post_id, :rate

  def validate_rate_value
    raise RatingValidationError, RatingValidationError::VALUE if rate.to_i < 1 || rate.to_i > 5
  end

  def validate_post_id
    raise RatingValidationError, RatingValidationError::POST_ID if post_id.blank?
  end

  def create_rating
    Rating.create(value: rate, post_id: post_id)
  end
end
