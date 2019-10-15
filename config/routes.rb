Rails.application.routes.draw do
  root 'users#new'
  get 'sessions/new'
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'
  post   'signup',  to: 'users#create'
  get    'index',   to: 'games#index'
  get    'new_game', to: 'games#new_game'
  resources :users
  resources :games
end
