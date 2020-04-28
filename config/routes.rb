Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/signup', to: 'users#new'
  resources :users
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :microposts, only: [:new, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end
