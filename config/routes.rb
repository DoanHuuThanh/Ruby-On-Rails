Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help', as: 'help'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end

  # Thông qua tùy chọn only,hỉ muốn định nghĩa hành động edit cho tài nguyên này.chỉ có một route và một action là edit sẽ được tạo ra để xử lý việc chỉnh sửa thông tin của tài khoản kích hoạt.
  resources :account_activations, only: :edit
  resources :password_resets, only: %i[create new update edit]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
