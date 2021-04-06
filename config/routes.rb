Rails.application.routes.draw do
  resources :users
  resources :questions
  root 'users#index'

  get 'show', to: 'users#show'
end
