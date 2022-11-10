Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/login', to: 'home#login'
  get '/signup', to: 'home#signup'
  
  post '/login', to: 'home#login'
  get '/logout', to: 'home#logout'
  post '/signup', to: 'home#signup'
  
  root to: 'qr_codes#profile'
  get 'profile', to: 'qr_codes#profile'
  get 'scanner', to: 'qr_codes#scanner'
  get 'history', to: 'qr_codes#history'
  get 'history_data', to: 'qr_codes#history_data'

  get 'settings', to: 'qr_codes#settings'


  post '/qr_approve_ticket', to: 'qr_codes#qr_approve_ticket'
  post '/qr_reject_ticket', to: 'qr_codes#qr_reject_ticket'
  

  #get 'get_all_qr_history', to: 'qr_history#get_all_qr_history'
  #get 'get_crnt_usr_qr_history', to: 'qr_history#get_crnt_usr_qr_history'

  post 'get_all_qr_history', to: 'qr_codes#get_all_qr_history'
  post 'get_crnt_usr_qr_history', to: 'qr_codes#get_crnt_usr_qr_history'


  post 'fetch_data', to: 'qr_codes#fetch_data'
  get 'qr_reader', to: 'qr_codes#index'
  get 'test', to: 'qr_codes#test'

  #post 'qr_validate', to: 'qr_codes#validate'
  get 'qr_validate', to: 'qr_codes#validate'

  
  

end