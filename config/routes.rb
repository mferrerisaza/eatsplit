Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :restaurants, only: :show do
    resources :dishes, only: :index
  end
end
