class CreatePost
  def initialize(params)
    @params = params
  end

  def call
    validate_post_params
    validate_user_params
    find_or_create_user
    create_post
  end

  private

  attr_reader :params, :user

  def validate_post_params
    raise PostValidationError, PostValidationError::TITLE     if params[:title].blank?
    raise PostValidationError, PostValidationError::CONTENT   if params[:content].blank?
  end

  def validate_user_params
    raise PostValidationError, PostValidationError::LOGIN     if params[:login].blank?
    raise PostValidationError, PostValidationError::AUTHOR_IP if params[:author_ip].blank?
  end

  def find_or_create_user
    @user ||= User.find_or_create_by(login: params[:login])
  end

  def create_post
    Post.create(params.except(:login).merge(user_id: user.id, user_login: user.login))
  end
end
