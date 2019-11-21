Rails.application.routes.draw do
  resources :comments
  resources :watchers
  resources :votes
  resources :users
  resources :issues
  get '/users/current_user' => "users#the_current_user", as: :current_user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'issues#index'
  
  # Routes for Google authentication
  #get ‘auth/:provider/callback’, to: ‘sessions#googleAuth’
  #get ‘auth/failure’, to: redirect(‘/’)

  #Routes for vote
  post '/issues/:id/vote' => "issues#vote", as: :vot
  post '/issues/:id/watcher/:index' => "issues#watcher", as: :watch
  put '/issues/:id/status' => "issues#update_status", as: :update_status

end
