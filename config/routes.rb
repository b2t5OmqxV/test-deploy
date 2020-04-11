Rails.application.routes.draw do

  # get 'relationships/create'
  # get 'relationships/destroy'
  devise_for :users

  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books, only:[:index, :show, :edit, :create, :update, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resource :book_comments, only: [:create, :destroy]
  end

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  get "search" => "searches#search"

end
