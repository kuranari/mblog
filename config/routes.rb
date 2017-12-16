Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:show, :create]
  post 'login' => 'sessions#create'
end
