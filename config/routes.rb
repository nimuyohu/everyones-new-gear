Rails.application.routes.draw do
  get 'users/show'
  root 'posts#index'
  devise_for :users

  resources :posts do
    get 'images', :on => :collection
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
