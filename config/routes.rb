Rails.application.routes.draw do
 
   # Ruta para el Storefront
  resources :storefront, only: [:index, :show], controller: "storefront"

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
  root "storefront#index"
  get "home/index"
  
  get "up" => "rails/health#show", as: :rails_health_check

end
