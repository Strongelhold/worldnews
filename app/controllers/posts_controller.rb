class PostsController < ApplicationController
  def index
    result = PostsByRating.new(index_params[:limit] || 10).call
    render json: result.map { |post| PostShortSerializer.new(post) }
  end

  def create
    post = CreatePost.new(create_params.merge(author_ip: request.remote_ip)).call
    render json: PostSerializer.new(post)
  rescue PostValidationError => error
    render json: { error: error.message }, status: 422
  end

  def authors_with_same_ip
    result = AuthorsWithSameIp.new.call
    render json: result
  end

  private

  def index_params
    params.permit(:limit)
  end

  def create_params
    params.permit(:title, :content, :login, :author_ip)
  end
end
