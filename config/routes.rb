Rails.application.routes.draw do
  resources :comments
  resources :watchers
  resources :votes
  resources :users
  resources :issues
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'issues#index'
  
  # Routes for Google authentication
  get ‘auth/:provider/callback’, to: ‘sessions#googleAuth’
  get ‘auth/failure’, to: redirect(‘/’)

end
