Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'qr_codes#index'
  
  get 'qr_reader', to: 'qr_codes#index'
  get 'qr_reader2', to: 'qr_codes#index2'

  post 'qr_validate/:data', to: 'qr_codes#validate'
  get 'qr_validate', to: 'qr_codes#validate_view'
  
  

end