Rails.application.routes.draw do
  get 'landing/index'
  get 'welcome/index'

  resources :users

  root to: 'landing#index'
end
