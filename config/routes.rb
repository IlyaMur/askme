Rails.application.routes.draw do
  resources :users, except: [:destroy]
  resources :questions, only: %i[new create destroy]
  resources :sessions
  root 'users#index'

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
