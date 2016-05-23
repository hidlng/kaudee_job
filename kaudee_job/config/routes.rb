KaudeeJob::Application.routes.draw do
  get 'password_resets/new'

  namespace :api do
    namespace :v1 do
      resources :market
      resources :room
      resources :user
      resources :favorite
      resources :category
      resources :city
      resources :car
      resources :district
      resources :image
      resources :model
      get 'meta' => 'meta#index'
      post 'login' => 'login#index'
    end
  end
end

Rails.application.routes.draw do
  get 'password_resets/new'

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'map/list'
  get 'map/show'
  get 'map/new'
  get 'map/ios'
  get 'welcome/index'
  get 'welcome/policy' => 'welcome#policy'
  get 'welcome/test' => 'welcome#test'
  get 'password' => 'welcome#password'
  post 'login' => 'login#index'
  get 'signout' => 'login#signout'
  get 'market/enable' => 'market#enable'
  get 'market/disable' => 'market#disable'
  get 'admin' => 'user#admin'
  get 'geno' => 'user#geno'

  resources :market
  resources :room
  resources :user
  resources :car
  resources :favorite
  resources :image
  resources :category
  resources :district
  resources :city
  resources :brand
  resources :model
  resources :password_resets
end
