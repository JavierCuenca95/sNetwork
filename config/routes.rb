Rails.application.routes.draw do
  resources :post_attachments
  get "/pages/:page" => "pages#show"


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
  post '/mark_notification', to: "interactions#markNotificationRead", as: :mark_notification


  resources :posts
  get 'timeline', to: 'posts#index', as: :timeline

  get '/about', :to => redirect('/about.html.erb')


  resources :users, :only => [:show]


  get 'friend/show', to: 'friend#show', as: :friend

  get 'interactions/show', to: 'interactions#show', as: :interactions

  Rails.application.routes.draw do
  resources :post_attachments
    get "/pages/:page" => "pages#show"
  end
  #root to: 'posts#index'
  root "pages#show", page: "home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
