Rails.application.routes.draw do
  resources :documents
  resources :events

  root 'logins#homepage'

  get 'auth/:provider/callback', to: 'logins#create'
  get 'auth/failure', to: redirect('/login')
  get '/log_user', to: 'logins#logout', as: 'logout'

  get '/login' => 'logins#login'
  get '/forgot' => 'logins#forget'
  get '/log' => 'logins#log_user'
  get '/dashboard' => 'logins#dashboard'
  get '/accept_request' => 'logins#accept_request'
  get '/delete_request' => 'logins#delete_request'
  get '/receive_document' => 'logins#receive_document'

  get '/delete_user' => 'account#delete_user'
  get '/create_account' => 'account#create_account'
  get '/up_mail' => 'account#up_mail'
  get '/profile_information' => 'account#profile_information'
  get '/edit_profile_information' => 'account#edit_profile_information'
  get '/update_profile_information' => 'account#update_profile_information'
  post '/update_profile_information' => 'account#update_profile_information'
  post '/redirect_acct' => 'account#redirect_account'

  get '/view_event' => 'events#view_event'
  get '/add_event' => 'events#add_event'
  get '/submit_event' => 'events#submit_event'
  get '/forward' => 'events#forward'
  get '/send_document' => 'events#send_document'

  get '/add_document' => 'documents#add_document'
  get '/update_document' => 'documents#update_document'
  get '/view_documents' => 'documents#view_documents'
  get '/delete_document' => 'documents#delete_document'
  get '/edit_document_view' => 'documents#edit_document_view'
  post '/update_document' => 'documents#update_document'

  get '/folders' => 'folders#folders'
  get '/folder_year' => 'folders#folder_year'
  get '/document_by_folder' => 'folders#document_by_folder'

  get '/attachments' => 'attachments#view_file'
  get '/view_file' => 'attachments#view_file'
  get '/upload_file' => 'attachments#upload_file'
  get '/save_file' => 'attachments#save_file'
  get '/delete_file' => 'attachments#delete_file'
  post '/attachments' => 'attachments#save_file'

  get '/settings' => 'settings#settings'
  get '/add_doctype' => 'settings#add_doctype'
  get '/delete_doctype' => 'settings#delete_doctype'
  get '/edit_doctype' => 'settings#edit_doctype'
  get '/add_jobtitle' => 'settings#add_jobtitle'
  get '/delete_jobtitle' => 'settings#delete_jobtitle'
  get '/edit_jobtitle' => 'settings#edit_jobtitle'
  get '/edit_users' => 'settings#edit_users'
  get '/delete_users' => 'settings#delete_users'
  post '/update_users' => 'settings#update_users'
  post '/update_doctype' => 'settings#update_doctype'
  post '/update_jobtitle' => 'settings#update_jobtitle'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
