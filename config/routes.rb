Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :create, :update, :destroy] do
    put 'favorites' => 'favorites#create'
    delete 'favorites' => 'favorites#destroy'
  end

  resources :users, only: [:show, :create]
  post 'login' => 'sessions#create'
end
