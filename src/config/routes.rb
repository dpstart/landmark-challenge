Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'custom_omniauth_callbacks#omniauth_success'

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
  resources :citys
  resources :users
  resources :profiles
  
  root to: 'landing#index'
end
