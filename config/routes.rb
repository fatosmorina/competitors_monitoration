Rails.application.routes.draw do

  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :groups

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  root to: "groups#index"
end
