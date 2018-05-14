Rails.application.routes.draw do
  devise_for :users
  get 'landing/index'
  get 'welcome/index'

  resources :users

  root to: 'landing#index'
end
