Rails.application.routes.draw do
  root 'articles#index'	
  resources :articles do
  	resources :comments
  end
  resources :tags	
  #get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
