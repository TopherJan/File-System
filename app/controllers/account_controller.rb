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
    @current_user = User.find_by(emailadd: params[:email])
	@email_add = params[:email_add]
  end

  def update_profile_information
    current_user = User.find_by(emailadd: params[:emailadd])
	current_user.update(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])
	
	flash[:notice] = "Profile successfully updated!"
	redirect_to '/profile_information'
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
  
	@user = User.new(:emailadd => @emailadd, :password => @password, :first_name => @first_name, :last_name => @last_name, :job_title => @job_title, :phone => @phone)
      
    if !(@user.save)
      flash[:error] = "Email already taken!"
	  redirect_to '/create_account'
    else
      flash[:success] = "Account successfully registered!"
      redirect_to '/'
    end 
  end

  def delete_user
   @current_user = User.find_by(emailadd: session[:current_user_emailadd])
	@emailadd = session[:current_user_emailadd]
    @user = User.find_by(:emailadd => @emailadd)
	User.delete(@emailadd)
	User.delete(@user)

    flash[:success] = "Account was deleted successfully!"
    redirect_to '/'
  end
end
