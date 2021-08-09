Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
    resource :favorites,only:[:create, :destroy]
    resources :book_comments,only:[:create, :destroy]
  end
  resources :relationships,only:[:create, :destroy]
  get 'users/:id/followings'=>'relationships#followings',as:'followings'
  get 'users/:id/followers'=>'relationships#followers',as:'followers'

  get '/searches' => 'searches#search'

  get 'chat/:id'=> 'chats#show',as: 'chat'
  resources :chats, only: [:create]


end