Rails.application.routes.draw do
  devise_for :users
  root 'toilets#index'
  get 'toilets/searchtoilet', to: 'toilets#search_toilet'
  resources :toilets do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
