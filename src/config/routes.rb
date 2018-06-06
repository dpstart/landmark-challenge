Rails.application.routes.draw do

  get '/auth/:provider/callback', to: 'custom_omniauth_callbacks#omniauth_success'

  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations' 
  } 
  
  # Check if a user (providing email as parameter) has already registered
  post '/auth/exists', to: 'custom_users#exists'
  mount_devise_token_auth_for 'Admin', at: 'admin/auth'
  as :admin do
    # Define routes for Admin within this block.
  end

  # Fuck session-based authentication
  # devise_for :users, :controllers => {:registrations => "registrations"}

  get 'landing/index'
  get 'welcome/index'

  get '/landmarks/visited', to:'landmarks#visited'
  resources :landmarks

  get '/citys/find_id_by_name', to: 'citys#find_id_by_name'  
  resources :citys

  get '/profiles/achievements', to: 'profiles#achievements'
  get '/profiles/goals', to: 'profiles#goals'
  get '/profiles/reputation', to:'profiles#reputation'
  resources :profiles

  resources :hasearneds
  resources :hasvisiteds
  
  root to: 'landing#index'

  post 'landmark_detection', to: 'landmark_detection#detection'

  # Administration
  get '/administration/stats', to: 'administration#stats'
  get '/administration/users', to: 'administration#users'
  get '/administration/admins', to: 'administration#admins'
  get '/administration/landmarks', to: 'administration#landmarks'
  get '/administration/cities', to: 'administration#cities'
  get '/administration/delete_user', to: 'administration#delete_user'
  get '/administration/new_admin', to: 'administration#new_admin'
end
