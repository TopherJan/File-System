Rails.application.routes.draw do
  root 'logins#login'
  resources :documents
  resources :events

  get '/create_account' => 'account#create_account'
  get '/forgot' => 'logins#forget'
  get '/log_user' => 'logins#login'
  get '/log' => 'logins#log_user'
  get 'forgot' => 'logins#forget'

  get '/dashboard' => 'logins#dashboard'
  get '/view_documents' => 'documents#view_documents'
  get '/view_event' => 'events#view_event'
  get '/add_document' => 'documents#add_document'
  get '/add_event' => 'events#add_event'
  put '/view_event' => 'events#view_event'

  get '/submit_event' => 'events#submit_event'
  get '/add_event_path' => 'events#add_event'
  post '/add_event' => 'events#add_event'
  post '/add_documents' => 'documents#add_documents'
  post '/view_event' => 'events#view_event'
  post '/view_documents' => 'documents#view_documents'

  get '/folders' => 'documents#folders'

  get '/profile_information' => 'account#profile_information'
  post '/edit_profile_information' => 'account#edit_profile_information'
  post '/update_profile_information' => 'account#update_profile_information'
  post '/redirect_acct' => 'account#redirect_account'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
