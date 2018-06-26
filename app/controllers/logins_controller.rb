class LoginsController < ApplicationController
  before_action :set_login, only: [:show, :edit, :update, :destroy]

  def login

  end
  
  def log_user
	flash[:notice] = "Log in successful."
	redirect_to '/view_documents'
  end
  
  def index
  
  end

end
