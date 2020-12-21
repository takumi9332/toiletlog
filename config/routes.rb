Rails.application.routes.draw do
  devise_for :users
  root 'toilets#index'
  resources :toilets
  resources :users, only: :show
end
