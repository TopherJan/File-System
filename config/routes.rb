Rails.application.routes.draw do
  root "logins#index"
  get '/create_account' => 'account#create_account'
  get '/log_user' => 'documents#view_documents'
   
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
