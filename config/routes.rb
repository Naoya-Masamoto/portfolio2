Rails.application.routes.draw do

  root 'posts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # Twitter & Google認証用
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  
  resources :users, only: %i[show] do
    member do
      get :followings, :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]

  resource :profile, only: %i[show]
  get 'profile/:id/liked_posts', to: 'users#liked_posts', as: 'profile_liked_posts'

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
    #↓投票機能
    resources :vote_histories, only: %i[create destroy]
  end

  #カテゴリー全表示のやつ
  get 'categories', to: 'categories#index'

  #カテゴリー別の表示のやつ↓
  get 'posts/brand/:id', to: 'posts#brand'
  get 'posts/shape/:id', to: 'posts#shape'
  get 'posts/color/:id', to: 'posts#color'

  #↓検索機能のためのルーティング
  get '/search', to: 'search#index'

end
