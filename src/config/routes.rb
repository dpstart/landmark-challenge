Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  #devise_for :users, :controllers => {:registrations => "registrations"}

  get 'landing/index'
  get 'welcome/index'

  #resources :users
  resources :landmarks
  resources :citys
  root to: 'landing#index'
end
