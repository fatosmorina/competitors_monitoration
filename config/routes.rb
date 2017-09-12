Rails.application.routes.draw do

  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :groups

  root to: "groups#index"
end
