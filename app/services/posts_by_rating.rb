class PostsByRating
  def initialize(limit)
    @limit = limit
  end

  def call
    Post.group('posts.id').joins(:ratings).order('AVG(ratings.value) DESC').limit(@limit)
  end
end
