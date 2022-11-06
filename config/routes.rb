Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/login', to: 'home#login'
  get '/signup', to: 'home#signup'
  
  post '/login', to: 'home#login'
  get '/logout', to: 'home#logout'
  post '/signup', to: 'home#signup'
  
  root to: 'qr_codes#index'
  get 'profile', to: 'qr_codes#profile'
  get 'qr_data', to: 'qr_code#fetch_data'
  
  get 'qr_reader', to: 'qr_codes#index'
  get 'test', to: 'qr_codes#test'

  post 'qr_validate', to: 'qr_codes#validate'
  #get 'qr_validate', to: 'qr_codes#validate_view'
  
  

end