Rails.application.routes.draw do
  resources :appointments do
    collection do 
      get :get_users
      get :get_slots
    end
  end
  resources :availabilities do
    collection do
      get :booked_appointments
    end
  end
  devise_for :users
  root "passthrough#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
