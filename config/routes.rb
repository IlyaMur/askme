Rails.application.routes.draw do
  resources :questions, except: %i[show new index]
  resources :users
  resources :sessions, only: %i[new create destroy]
  root 'users#index'

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
