Rails.application.routes.draw do
  root to: 'pages#home'
  # Static pages
  get 'about-us', to: 'pages#about_us'

  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  # namespace the controllers without affecting the URI
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      resources :users
      post 'password/forgot', to: 'password#forgot'
      post 'password/reset', to: 'password#reset'
      resources :services
    end
  end
end
