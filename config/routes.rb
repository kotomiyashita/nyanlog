Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  get 'users/search', to: 'users#search'
  root to: "rooms#index"
  resources :users, only: [:edit, :update, :search]
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
end
