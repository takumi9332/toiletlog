Rails.application.routes.draw do
  devise_for :users
  root 'toilets#index'
  get 'toilets/searchtoilet', to: 'toilets#search_toilet'
  resources :toilets do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: :show do
    get :favorites, on: :collection
  end
end
