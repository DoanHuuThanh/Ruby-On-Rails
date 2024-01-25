# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: 'confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  as :user do
    get '/signout' => 'devise/sessions#destroy'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about', as: 'about'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: :edit
  resources :password_resets, only: %i[create new update edit]
  resources :microposts, only: %i[create destroy show]
  resources :relationships, only: %i[create destroy]
  resources :comments, only: %i[create update destroy]
  resources :reactions, only: %i[create]
  resources :messages
  resources :conversations do
    member do
      get 'user_conversation'
    end
    collection do
      post 'add_user_to_group'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
