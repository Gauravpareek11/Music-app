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
end
