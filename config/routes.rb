Rails.application.routes.draw do
  
  resources :news, only: [ :index, :show ]
  
  devise_for :users, :path_prefix => 'my', controllers: { registrations: 'users/registrations' }
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :users, path: '', only: [ :index ]
    resources :users, except: [ :index, :new ]
    resources :news
  end
  
  resources :users
  get '/profile', to: 'users#edit', via: 'get', :as => :profile
  
end
