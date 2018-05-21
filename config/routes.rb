Rails.application.routes.draw do
  resources :posts, only: %i[index create] do
    get :authors_with_same_ip, on: :collection
  end
  resources :ratings, only: :create
end
