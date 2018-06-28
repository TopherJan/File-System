class LoginsController < ApplicationController

	before_action :confirm_logged_in, :only => [:logout]
	attr_accessor :user, :dash

  def login

  end

def log_user
		@emailadd = params[:emailadd]
		@password = params[:password]

		@user = User.where("emailadd = ? AND password = ?", @emailadd, @password)


		if @user.empty?
			flash[:error] = "Incorrect Email address or Password. Try Again."
			redirect_to '/'
		else
			flash[:notice] = "Log in successful."
			session[:current_user_emailadd] = @emailadd
			session[:current_user_password] = @password
			redirect_to controller: "documents", action: "view_documents"
		end

	end
  def logout
		reset_session
		redirect_to '/'
	end

end
