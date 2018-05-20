class CalculateAveragePostRating
  def initialize(post_id)
    @post_id = post_id
  end

  def call
    calculate_average_rating
  end

  private

  attr_reader :post_id

  def post
    @post ||= Post.find(post_id)
  end

  def calculate_average_rating
    return 0 if post.ratings.count.zero?
    post.ratings.pluck(:value).sum / post.ratings.count
  end
end
