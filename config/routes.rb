Rails.application.routes.draw do
  root to: 'pages#home'
  # Static pages
  get 'stylists', to: 'pages#stylists'
  get 'faq', to: 'pages#faq'
  get 'about-us', to: 'pages#about_us'

  resources :user_sessions
  resources :users do
    member do
      get :activate
    end
  end
  resources :password_resets

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout


  # namespace the controllers without affecting the URI
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#authenticate'
      resources :users
    end
  end
end
