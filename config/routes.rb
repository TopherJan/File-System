Rails.application.routes.draw do
  root "logins#login"
  get 'forgot' => 'logins#forget'
  get '/dashboard' => 'logins#dashboard'
  get '/create_account' => 'account#create_account'
  get '/log_user' => 'logins#login'
  get '/view_documents' => 'documents#view_documents'
  get '/view_event' => 'events#view_event'
  get '/add_document' => 'documents#add_document'
  get '/add_event' => 'events#add_event'
  post '/redirect_account' => 'logins#login'
  post '/redirect_acct' => 'account#redirect_account'
  get '/log' => 'logins#log_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
