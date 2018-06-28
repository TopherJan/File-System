class AccountController < ApplicationController

	def profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@first_name = @current_user.first_name
		@last_name = @current_user.last_name
		@password = @current_user.password
		@jobtitle = @current_user.job_title
		@phone = @current_user.phone
		@emailadd = session[:current_user_emailadd]
	end

	def create_account
		@emailadd
		@firstname
		@lastname
		@password
		@jobtitle
		@phone
	end

  def redirect_account
		@firstname = params[:firstname]
		@lastname = params[:lastname]
		@emailadd = params[:emailadd]
		@password = params[:password]
		@jobtitle = params[:jobtitle]
		@phone = params[:phone]

		@user = User.create!(:emailadd => @emailadd, :password => @password, :first_name => @firstname, :last_name => @lastname, :job_title => @jobtitle, :phone => @phone)

		redirect_to controller: "logins", action: "log_user"
	end


end
