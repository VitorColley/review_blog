Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # Home page
  root "reviews#index"

  # User registration
  resources :users, only: [:new, :create, :show]

  # Search
  get "/search", to: "reviews#search"

  # Categories
  resources :categories, only: [:index, :show]

  # Items (movies, games, etc.)
  resources :items

  # Reviews with nested comments
  resources :reviews do
    resources :comments, only: [:create, :destroy]

    # uninplemented route:
    collection do
      get "top"  # /reviews/top
    end
  end

  # Tags
  resources :tags, only: [:index, :show]

end
