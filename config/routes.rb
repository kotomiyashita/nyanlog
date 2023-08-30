Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "rooms#index"
  resources :rooms, only: [:new, :create, :destroy] 
end
