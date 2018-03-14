Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "dishes/checkout", to: 'orders#checkout', as: :checkout

  resources :restaurants, only: :show do
    resources :dishes, only: :index do
      resources :orders, only: [:create, :update]
    end
  end
end
