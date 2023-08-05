# frozen_string_literal:true

# This is route file
# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  get 'welcomes/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcomes#index'

  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'
  get '/profile', to: 'users#profile', as: 'profile'
  get '/your_items', to: 'users#your_items', as: 'items_posted'
  get '/your_pending_items', to: 'users#your_pending_approvals', as: 'pending_items'
  get '/your_requirements', to: 'users#your_requirements', as: 'requirements_posted'
  get '/auth/google_oauth2/callback', to: 'sessions#omni_create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/categories/:id/subcategories', to: 'products#sub_categories'
  resources :admin, except: %i[destroy show] do
    collection do
      get :pending_approvals
      get :rejected
    end
    member do
      put :reject_post
    end
  end
  scope '/admin' do
    resources :categories, except: %i[show]
    resources :sub_categories, except: %i[show]
  end
  resources :products, except: %i[index] do
    resources :reviews, only: [:create]
    collection do
      get :buy
      get :search
      get :sell
      get :filter
    end
  end
  resources :conversations, only: %i[index show create] do
    resources :messages, only: [:create]
  end
  resources :notifications, only: %i[index create] do
    collection do
      get :read
    end
  end
  mount ActionCable.server => '/cable'

  match '*unmatched', to: 'application#not_found_method', via: :all, constraints: lambda { |req|
    !req.path.match(%r{\A/rails/active_storage/})
  }
end
# rubocop:enable Metrics/BlockLength
