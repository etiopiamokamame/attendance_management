Rails.application.routes.draw do
  root to: "login#index"

  resources :login, only: [:index] do
    collection do
      post :authenticate
    end
  end

  resources :user_configs, only: [:index, :destroy] do
    collection do
      post :save
    end
    member do
      post :init_password
    end
  end

  resources :attendances, only: [:index] do
    collection do
      post :save
    end
  end

  resources :users
  resources :reasons
  resources :articles
  resources :leave_types
  resources :holidays,       except: [:show]
  resources :top,            only:   [:index]
  resources :system_configs, only:   [:edit, :update]
  resources :leave_tables,   only:   [:index]
  resources :reports,        only:   [:index]
end
