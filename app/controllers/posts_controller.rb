class PostsController < ApplicationController
  def create
    post = CreatePost.new(create_params.merge(author_ip: request.remote_ip)).call
    render json: PostSerializer.new(post)
  rescue PostValidationError => error
    render json: { error: error.message }, status: 422
  end

  private

  def create_params
    params.permit(:title, :content, :login, :author_ip)
  end
end
