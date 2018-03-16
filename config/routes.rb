Rails.application.routes.draw do
  devise_for :users

  get "dishes/checkout", to: 'orders#checkout', as: :checkout
  # put "orders/bill_update", to: 'orders#bill_update', as: :bill_update
  resources :restaurants, only: :show do
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update]
    end
  end
  root to: 'restaurants#index'


  resources :tables, only: [:show]
    resources :bills, only: [:show] do
      resources :payments, only: [:create]
    end
  end
