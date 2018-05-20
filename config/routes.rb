Rails.application.routes.draw do
  resources :posts, only: %i[index create]
  resources :ratings, only: :create
end
