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
        patch :deactivate
      end
    end
  end
  devise_for :usuarios
  root "home#index"
  get "home/index"
  
  get "up" => "rails/health#show", as: :rails_health_check

end
