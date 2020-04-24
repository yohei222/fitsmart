Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get  '/about', to: 'static_pages#about'
  get  '/signup', to: 'users#new'
  resources :users
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :microposts,          only: [:new, :create, :destroy]
end
