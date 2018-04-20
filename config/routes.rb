Rails.application.routes.draw do
  devise_for :users

  get "dishes/checkout", to: 'orders#checkout', as: :checkout
  # put "orders/bill_update", to: 'orders#bill_update', as: :bill_update
  get "/location", to: 'restaurants#location', as: :location
  resources :restaurants, only: [:index, :show] do
    resources :tables, only: [:index]
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update],shallow: true
    end
  end
  root to: 'pages#home'
  get '/goodbye', to: "pages#goodbye", as: "goodbye"
  resources :tables, only: :show
  resources :bills, only: [:new, :show, :create, :update] do
    resources :payments, only: [:new, :create]
    resources :orders, only: :index
  end
end
