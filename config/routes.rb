Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users
    root "tours#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "sessions/new"
    resources :tours, only: %i(index show) do
      resources :bookings, except: %i(index), shallow: true
      resources :reviews, except: %i(index), shallow: true
    end
    resources :reviews, only: %i(index show) do
      resources :comments, only: %i(create destroy edit update)
    end
    resources :bookings, only: %i(index)
    resources :categories, only: %i(index show)
    namespace :admin do
      get "dasboard/index", to: "dasboard#index"
      patch "tours/status/:id", to: "tours#status", as: "status"
      resources :users
      resources :categories
      resources :tours
      resources :bookings
      resources :reviews
    end
  end
end
