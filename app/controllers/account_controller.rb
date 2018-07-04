class AccountController < ApplicationController


	skip_before_action :verify_authenticity_token


	def profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
    @emailadd = session[:current_user_emailadd]
		if(current_user.nil?)
 		  @password = @current_user.password
		  @first_name = @current_user.first_name
		  @last_name = @current_user.last_name
		  @job_title =@current_user.job_title
		  @phone = @current_user.phone
		end
	end

	def edit_profile_information

		@current_user = User.find_by(emailadd: session[:current_user_emailadd])
		@emailadd = session[:current_user_emailadd]

	  @password = session[:current_user_password]
  	@first_name = @current_user.first_name
	  @last_name = @current_user.last_name
	  @job_title = @current_user.job_title
	  @phone = @current_user.phone

		flash[:notice] = "NO CHANGES!"
	end


	def update_profile_information
		@current_user = User.find_by(emailadd: session[:current_user_emaidadd])
		@current_user.update(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])
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
