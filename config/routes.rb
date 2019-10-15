Rails.application.routes.draw do
  root 'users#new'
  get 'sessions/new'
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  post   'signup',  to: 'users#create'
  resources :users
  resources :games
end
