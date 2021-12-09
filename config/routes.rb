Rails.application.routes.draw do
  resources :news
  devise_for :users, :path_prefix => 'my', controllers: { registrations: 'users/registrations' } 
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
