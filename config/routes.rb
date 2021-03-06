Rails.application.routes.draw do
  resources :labels
  namespace :admin do
    resources :users
  end
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit]
  resources :sessions, only: [:new, :create, :destroy]
  root 'users#new'
end
