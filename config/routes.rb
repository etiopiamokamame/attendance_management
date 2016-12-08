Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :login, only: [:new] do
    collection do
      post "new"
      get :logout
    end
  end

  resources :top,      only: [:index]
  resources :articles, only: [:index, :show, :new, :edit, :destroy] do
    collection do
      post "new", as: :new
    end
    member do
      post "edit", as: :edit
    end
  end

  root to: redirect("login/new")

  post "/toggle_sidebar" => "application#toggle_sidebar"

  # page not found
  get "*path", controller: "application", action: "render_404"
end
