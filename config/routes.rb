Rails.application.routes.draw do
  root to: "login#index"

  resources :login, only: [:index] do
    collection do
      post :authenticate
      get :logout
      post :toggle_sidebar
    end
  end

  resources :user_configs, only: [:index, :update, :destroy] do
    collection do
      get :attendance
    end
    member do
      post :init_password
    end
  end

  resources :attendances, only: [:index] do
    collection do
      get :prev_month
      get :next_month
      post :save
      post :export
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

  # page not found
  get '*path', controller: 'application', action: 'render_404'
end
