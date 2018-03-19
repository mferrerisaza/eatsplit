Rails.application.routes.draw do
  devise_for :users

  get "dishes/checkout", to: 'orders#checkout', as: :checkout
  # put "orders/bill_update", to: 'orders#bill_update', as: :bill_update
  get "/location", to: 'restaurants#location', as: :location
  resources :restaurants, only: [:index, :show] do
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update]
    end
  end
  root to: 'pages#landing_page'
  resources :tables, only: :show
    resources :bills, only: [:new, :show, :create, :update] do
      resources :payments, only: [:create]
    end
end
