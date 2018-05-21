class RatePost
  def initialize(post_id, rate)
    @post_id = post_id
    @rate = rate
  end

  def call
    validate_rate_value
    validate_post_id
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.connection.execute('LOCK ratings IN ACCESS EXCLUSIVE MODE')
      create_rating
      average_rating = calculate_average_rating
      add_average_rating_to_post(average_rating)
      average_rating
    end
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

  def calculate_average_rating
    CalculateAveragePostRating.new(post_id).call
  end

  def add_average_rating_to_post(average_rating)
    Post.find(post_id).update(average_rating: average_rating)
  end
end
