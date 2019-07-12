Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/docs'

  root to: 'pages#home'
  # Static pages
  get 'stylists', to: 'pages#stylists'
  get 'faq', to: 'pages#faq'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
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

      post 'clients/signup', to: 'clients_signup#create'
      post 'stylists/signup', to: 'stylists_signup#create'
      resources :clients
      resources :stylists do
        collection do
          get 'nearest_stylists', to: 'stylists#nearest_stylists'
        end
      end
      resources :services do
        collection do
          get 'nearest_services', to: 'services#nearest_services'
        end
      end
      resources :service_types
      resources :schedules
      resources :availabilities
      resources :favorites
      resources :bookings do
        member do
          put 'confirm'
          put 'reject'
        end
        collection do
          get 'upcoming_appointments', to: 'bookings#upcoming_appointments'
          get 'past_appointments', to: 'bookings#past_appointments'
        end
      end
      resources :payments
      resources :messages
      resources :cards
      resources :contacts, only: [:create]
      resources :reviews
    end
  end
end
