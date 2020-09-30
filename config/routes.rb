Rails.application.routes.draw do
  resources :tasks
  resources :users
  resources :sessions
  root 'tasks#index'
end
