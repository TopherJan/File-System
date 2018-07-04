class AccountController < ApplicationController


	skip_before_action :verify_authenticity_token



	def profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@emailadd = session[:current_user_emailadd]

		if(@emailadd.nil?)
			@emailadd = @current_user.id_token
			@first_name = @current_user.name

		else
			@emailadd = session[:current_user_emailadd]
  		@first_name = @current_user.first_name
  		@last_name = @current_user.last_name
  		@password = @current_user.password
  		@job_title = @current_user.job_title
  		@phone = @current_user.phone

		end

	end



	def edit_profile_information

		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@emailadd = session[:current_user_emailadd]

		if(@emailadd.nil?)
			@emailadd = @current_user.id_token
		else
		  @password = session[:current_user_password]
		  @emailadd = session[:current_user_emailadd]
	  	@first_name = @current_user.first_name
		  @last_name = @current_user.last_name
		  @job_title = @current_user.job_title
		  @phone = @current_user.phone
		end

		flash[:notice] = "NO CHANGES!"
	end


	def update_profile_information
		@current_user = User.find_by(emailadd: session[:current_user_id_token])
		@current_user.update(emailadd: session[:current_user_id_token],first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])
		flash[:notice] = "SUCCESSFULLY UPDATED!"
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
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@emailadd = session[:current_user_emailadd]

  	@first_name = params[:first_name]
  	@last_name = params[:last_name]
  	@emailadd = params[:emailadd]
  	@password = params[:password]
  	@job_title = params[:job_title]
  	@phone = params[:phone]

		@user = User.create!(:emailadd => @emailadd, :password => @password, :first_name => @first_name, :last_name => @last_name, :job_title => @job_title, :phone => @phone)

		flash[:success] = "SUCCESSFULLY REGISTERED!"
		redirect_to '/'

	end

	def delete_user
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@emailadd = session[:current_user_emailadd]
		@user = User.find_by(:emailadd => @emailadd)
		User.delete(@emailadd)
		User.delete(@user)

		flash[:warning] = "ACCOUNT SUCCESSFULLY DELETED!"
		redirect_to '/'
	end

end
