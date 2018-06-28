class AccountController < ApplicationController


	skip_before_action :verify_authenticity_token
	def profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@first_name = @current_user.first_name
		@last_name = @current_user.last_name
		@password = @current_user.password
		@job_title = @current_user.job_title
		@phone = @current_user.phone
		@emailadd = session[:current_user_emailadd]
	end

	def edit_profile_information
		@password = session[:current_user_password]
		@emailadd = session[:current_user_emailadd]
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@first_name = @current_user.first_name
		@last_name = @current_user.last_name
		@job_title = @current_user.job_title
		@phone = @current_user.phone
	end


	def update_profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@current_user.update(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])
		redirect_to "/profile_information"
	end


		def create_account
			@emailadd
			@first_name
			@last_name
			@password
			@job_title
			@phone
		end

		def redirect_account
			@first_name = params[:first_name]
			@last_name = params[:last_name]
			@emailadd = params[:emailadd]
			@password = params[:password]
			@job_title = params[:job_title]
			@phone = params[:phone]

			@user = User.create!(:emailadd => @emailadd, :password => @password, :first_name => @first_name, :last_name => @last_name, :job_title => @job_title, :phone => @phone)

			redirect_to controller: "logins", action: "log_user"
		end


	end
