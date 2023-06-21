Rails.application.routes.draw do
  get 'welcomes/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcomes#index"

  get '/signup', to: "users#new"
  post '/users', to: "users#create"

  get '/auth/google_oauth2/callback', to: 'sessions#omni_create'
  get '/login',to: 'sessions#new'
  post '/login',to:'sessions#create'
  get '/logout',to:'sessions#destroy'
  get '/categories/:id/subcategories',to:'products#sub_categories'
  resources :admin do
    resources :categories,only: [:new,:create]
    resources :sub_categories,only: [:new,:create]
    collection do
      get :pending_approvals
    end
  end
  resources :products,only: [:new,:create,:destroy]
  resources :conversations, only: [:index,:show,:create] do
    resources :messages, only: [:create]
  end
  resources :notifications, only: [:index,:create]
  mount ActionCable.server => '/cable'
end
