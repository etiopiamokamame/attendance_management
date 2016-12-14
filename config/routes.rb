Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  concern :custom_restful do
    collection do
      post "new", as: :new
    end
    member do
      post "edit", as: :edit
    end
  end

  resources :login, only: [:new] do
    collection do
      post "new"
      get :logout
    end
  end

  resources :top, only: [:index]

  resource :system_config,
    only: [:edit, :update] do
    member do
      post "edit", as: :edit
    end
  end

  resources :login, only: [:new] do
    collection do
      post "new"
      get :logout
    end
  end

  resources :top, only: [:index]

  resources :articles,
    only: [:index, :show, :new, :edit, :destroy],
    concerns: :custom_restful

  resources :special_days,
    only: [:index, :new, :edit, :destroy],
    concerns: :custom_restful

  root to: redirect("login/new")

  post "/toggle_sidebar" => "application#toggle_sidebar"

  # page not found
  get "*path", controller: "application", action: "render_404"
end
