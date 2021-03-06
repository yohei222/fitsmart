Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/signup', to: 'users#new'
  resources :users
  get 'users/:id/chart', to: 'users#chart', as: :chart
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :microposts, only: [:new, :create, :edit, :show, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end
  resources :likes, only: [:create, :destroy]
end
