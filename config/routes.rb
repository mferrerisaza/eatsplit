Rails.application.routes.draw do
  devise_for :users
  get "dishes/checkout", to: 'orders#checkout', as: :checkout
  get "/location", to: 'restaurants#location', as: :get_location
  resources :restaurants, only: :show do
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update]
    end
  end
  root to: 'restaurants#index'
  resources :tables, only: :show
    resources :bills, only: [:new, :show, :create, :update] do
      resources :payments, only: [:new, :create]
    end

end
