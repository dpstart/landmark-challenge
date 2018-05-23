Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'custom_omniauth_callbacks#omniauth_success'

  mount_devise_token_auth_for 'User', at: 'auth'

  #devise_for :users, :controllers => {:registrations => "registrations"}

  get 'landing/index'
  get 'welcome/index'

  #resources :users

  root to: 'landing#index'
end
