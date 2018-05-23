Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'custom_omniauth_callbacks#omniauth_success'

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'registrations' 
    } 

  mount_devise_token_auth_for 'Admin', at: 'admin/auth'
  as :admin do
    # Define routes for Admin within this block.
  end

  #devise_for :users, :controllers => {:registrations => "registrations"}

  get 'landing/index'
  get 'welcome/index'

  resources :landmarks
  resources :citys
  resources :profiles
  
  root to: 'landing#index'
end
