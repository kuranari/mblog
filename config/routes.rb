Rails.application.routes.draw do
  root to: 'home#show'
  resources :home, only: :show

  resources :articles, only: [:index, :show, :create, :update, :destroy] do
    put 'favorites' => 'favorites#create'
    delete 'favorites' => 'favorites#destroy'
  end

  post 'login' => 'sessions#create'
  post 'signup' => 'users#create'
end
