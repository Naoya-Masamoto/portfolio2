Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # Twitter & Google認証用
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  
  resources :users, only: %i[show]
  resource :profile, only: %i[show]
  get 'profile/:id/liked_posts', to: 'users#liked_posts', as: 'profile_liked_posts'

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :likes, only: [:create, :destroy]
  end

end
