Rails.application.routes.draw do
  root "logins#login"
  get '/create_account' => 'account#create_account'
  get '/log_user' => 'logins#login'
  get '/log' => 'logins#log_user'
  get 'forgot' => 'logins#forget'
  get '/dashboard' => 'logins#dashboard'
  get '/view_documents' => 'documents#view_documents'
  get '/view_event' => 'events#view_event'
  get '/add_document' => 'documents#add_document'
  get '/add_event' => 'events#add_event'
  get '/folders' => 'documents#folders'
	get '/profile_information' => 'account#profile_information'
  post '/redirect_account' => 'logins#login'
  post '/redirect_acct' => 'account#redirect_account'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
