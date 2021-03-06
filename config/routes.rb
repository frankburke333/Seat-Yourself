Rails.application.routes.draw do

  root 'restaurants#index'

  resource :users, only: [:new, :create]

  resource :sessions, only: [:new, :create, :destroy]

  resources :users do
    resources :reservations
  end

  resources :reservations

  resources :restaurants do
    resources :reviews, only: [:show, :create, :destroy]
  end

  resources :searches

end
