Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'users/:id/follower' => 'relationships#follower', as: 'follower'
  get 'users/:id/followed' => 'relationships#followed', as: 'followed'
   get '/search' => 'searchs#search'


  resources :users,only: [:show, :index, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :books do
    resource :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end