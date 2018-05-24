Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'custom_omniauth_callbacks#omniauth_success'

  # Check if a user (providing email as parameter) has already registered
  post '/auth/exists', to: 'custom_users#exists'

  mount_devise_token_auth_for 'User', at: 'auth'

  mount_devise_token_auth_for 'Admin', at: 'admin/auth'
  as :admin do
    # Define routes for Admin within this block.
  end

  #devise_for :users, :controllers => {:registrations => "registrations"}

  get 'landing/index'
  get 'welcome/index'

  #resources :users
  resources :landmarks

  get '/citys/find_id_by_name', to: 'citys#find_id_by_name'  
  resources :citys

  resources :users
  resources :profiles
  
  root to: 'landing#index'
end
