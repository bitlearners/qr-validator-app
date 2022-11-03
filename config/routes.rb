Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'qr_codes#index'
  
  get 'qr_reader', to: 'qr_codes#index'
  get 'test', to: 'qr_codes#test'

  post 'qr_validate', to: 'qr_codes#validate'
  #get 'qr_validate', to: 'qr_codes#validate_view'
  
  

end