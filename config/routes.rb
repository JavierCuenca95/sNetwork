Rails.application.routes.draw do
  get "/pages/:page" => "pages#show"
  get 'profile/show'

  get 'perfil/show'

  devise_for :users, controllers: {sessions: 'users/sessions', :registrations => 'users/registrations'}
  resources :posts

  devise_scope :user do
  	get "login", to: 'devise/sessions#new', as: :login
  	get "signup", to: 'devise/registrations#new', as: :signup
  	get "logout", to: 'devise/sessions#destroy', as: :logout


    # FRIENDSHIPS#
    post '/send_request', to: "users/registrations#sendRequest", as: :send_request
    post '/accept_request', to: "users/registrations#acceptRequest", as: :accept_request
    post '/decline_request', to: "users/registrations#declineRequest", as: :decline_request
    post '/remove_friend', to: "users/registrations#removeFriend", as: :remove_friend
  end

  #LIKE/DISLIKE POST
  post '/like_post', to: "posts#likePost", as: :like_post
  post '/dislike_post', to: "posts#dislikePost", as: :dislike_post


  resources :posts
  get 'timeline', to: 'posts#index', as: :timeline

  get '/:id', to: 'profile#show'

  resources :users, :only => [:show]


  get 'friend/show', to: 'friend#show', as: :friend
  #root to: 'posts#index'
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
