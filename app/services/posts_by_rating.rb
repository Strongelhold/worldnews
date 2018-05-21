class PostsByRating
  def initialize(limit)
    @limit = limit
  end

  def call
    Post.order(average_rating: :desc).limit(@limit)
  end
end
