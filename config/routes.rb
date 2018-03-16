Rails.application.routes.draw do
  devise_for :users

  get "dishes/checkout", to: 'orders#checkout', as: :checkout
  resources :restaurants, only: :show do
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update]
    end
  end
  root to: 'restaurants#index'
  resources :tables, only: :show
  resources :bills, only: [:show, :create, :update] do
    resources :payments, only: [:create]
  end

end
