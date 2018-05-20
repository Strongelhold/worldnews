Rails.application.routes.draw do
  resource :posts, only: :create
  resource :ratings, only: :create
end
