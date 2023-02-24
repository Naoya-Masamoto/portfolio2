Rails.application.routes.draw do

  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # Twitter & Google認証用
    :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  resource :profile, only: %i[show]
end
