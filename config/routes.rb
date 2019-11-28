Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  resources :users
  resources :issues
  resources :issues do
    resources :comments
  end
  get '/users/current_user' => "users#the_current_user", as: :current_user
  get  'static_pages/home'
  get  'static_pages/help'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  


  #Routes for vote
  post '/issues/:id/vote' => "issues#vote", as: :vot
  post '/issues/:id/watcher/:index' => "issues#watcher", as: :watch
  put '/issues/:id/status' => "issues#update_status", as: :update_status

  put '/issues' => 'application#set_current_user', as: :log



 

end
