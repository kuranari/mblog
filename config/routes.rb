Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :create, :update, :destroy] do
    put 'favorites' => 'favorites#create'
    delete 'favorites' => 'favorites#destroy'
  end

  post 'login' => 'sessions#create'
  post 'signup' => 'users#create'
end
