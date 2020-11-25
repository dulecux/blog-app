Rails.application.routes.draw do
  devise_for :authors
  root 'articles#index'	
  resources :articles do
  	resources :comments
  	get 'change_status'
  end
  resources :tags	
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
