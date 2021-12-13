Rails.application.routes.draw do
  
  
  
  namespace :admin1 do
    resources :users, path: '', only: [ :index ]
    resources :users, except: [ :index, :new ]
  end
  
  resources :news
  
  devise_for :users, :path_prefix => 'my', controllers: { registrations: 'users/registrations' } 
  root 'static_pages#home'
  #resources :users, path: '/profile', only: [ :edit_profile  ]
  # get '/profile', to: 'users#edit_profile', via: 'get', :as => :edit_profile
 #  post '/profile', to: 'users#update_profile', via: 'get', :as => :update_profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :admin do
    #resources :users, path: '', only: [ :index ]
    #resources :users, except: [ :index, :new ]
    resources :users
  end
  
  resources :users
  get '/profile', to: 'users#edit', via: 'get', :as => :profile
  
end
