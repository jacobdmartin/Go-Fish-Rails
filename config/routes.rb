Rails.application.routes.draw do
  root 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
  resources :games
end
