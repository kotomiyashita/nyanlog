Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:index, :new, :create, :destroy] do
    resources :messages do
      collection do
        get 'category'
      end
    end
  end
end
