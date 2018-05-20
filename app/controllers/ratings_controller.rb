class RatingsController < ApplicationController
  def create
    result = RatePost.new(create_params[:post_id], create_params[:rate]).call
    render json: { average_rate: result }
  rescue RatingValidationError => error
    render json: { error: error.message }, status: 422
  end

  private

  def create_params
    params.permit(:post_id, :rate)
  end
end
