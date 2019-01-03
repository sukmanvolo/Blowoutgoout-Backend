Rails.application.routes.draw do
  root to: 'pages#home'
  # Static pages
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
      resources :users
    end
  end  
end
