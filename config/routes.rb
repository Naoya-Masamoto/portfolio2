Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # Twitter & Google認証用
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  
  resources :users, only: %i[show]
  resource :profile, only: %i[show]

  resources :posts
end
