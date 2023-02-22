Rails.application.routes.draw do

  root 'home#index'
  devise_for :users, controllers: {
    # Twitter & Google認証用
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
end
