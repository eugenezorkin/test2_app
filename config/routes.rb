Rails.application.routes.draw do
  
  resources :news
  
  devise_for :users, :path_prefix => 'my', controllers: { registrations: 'users/registrations' } 
  root 'static_pages#home'
  resources :users, path: '/profile', only: [ :edit_profile  ]
   get '/profile', to: 'users#edit_profile', via: 'get', :as => :edit_profile
   post '/profile', to: 'users#update_profile', via: 'get', :as => :update_profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :admin do
    resources :users, path: '', only: [ :index ]
    resources :users, except: [ :index, :new, :update_profile, :edit_profile ]
    
  end
  
end
