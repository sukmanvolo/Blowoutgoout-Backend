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
  get 'stylists/signup', to: 'stylists#new', as: 'stylists_signup'
  resources :stylists, only: %i[create] do
    resources :signup, only: %i[show update]
  end


  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  # namespace the controllers without affecting the URI
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'facebook_authenticate' => 'facebook_authentication#create'
      resources :users
      post 'password/forgot', to: 'password#forgot'
      post 'password/reset', to: 'password#reset'

      post 'clients/signup', to: 'clients_signup#create'
      post 'stylists/signup', to: 'stylists_signup#create'
      resources :clients do
        member do
          post 'become_a_stylist', to: 'clients#become_a_stylist'
          patch 'save_gateway_token', to: 'save_gateway_token'
        end
      end
      resources :stylists do
        collection do
          get 'nearest_stylists', to: 'stylists#nearest_stylists'
          get 'available_stylists', to: 'stylists#available_stylists'
          get 'booked_payment_data', to: 'stylists#booked_payment_data'
          get 'next_payday_payment_data', to: 'stylists#next_payday_payment_data'
        end
        member do
          post 'gallery_images', to: 'stylists#gallery_images'
          delete 'gallery_images/:image_id', to: 'stylists#remove_gallery_image'
        end
      end
      resources :services do
        collection do
          get 'nearest_services', to: 'services#nearest_services'
        end
      end
      resources :service_types
      resources :schedules do
        collection do
          get 'nearest_schedules', to: 'schedules#nearest_schedules'
          get 'by_stylist', to: 'schedules#by_stylist'
          delete 'by_stylist', to: 'schedules#destroy_by_stylist'
        end
      end
      resources :availabilities do
        collection do
          get 'by_stylist', to: 'availabilities#by_stylist'
        end
      end
      resources :favorites
      resources :bookings do
        member do
          put 'confirm'
          put 'reject'
          put 'complete'
        end
        collection do
          get 'upcoming_appointments', to: 'bookings#upcoming_appointments'
          get 'past_appointments', to: 'bookings#past_appointments'
        end
      end
      resources :payments do
        collection do
          get 'by_stylist'
          get 'by_client'
        end
      end
      resources :messages
      resources :cards
      resources :contacts, only: [:create]
      resources :reviews do
        collection do
          get 'by_client', to: 'reviews#by_client'
          get 'by_booking', to: 'reviews#by_booking'
          get 'by_stylist', to: 'reviews#by_stylist'
        end
      end
      resources :notifications, only: :index
    end
  end
end
