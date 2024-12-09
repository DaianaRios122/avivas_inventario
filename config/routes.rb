Rails.application.routes.draw do

  resources :ventas, except: [:edit, :update] do
    member do
    end
  end

  resources :productos do
    member do
      get :edit_stock
      patch :change_stock
      get :precio
    end
  end
  
  namespace :admin do
    resources :usuarios, except: [:destroy] do
      member do
        patch :update_password
        patch :deactivate
      end
    end
  end
  devise_for :usuarios
  root "home#index"
  get "home/index"
  
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
