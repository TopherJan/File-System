class AccountController < ApplicationController
  skip_before_action :verify_authenticity_token
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def profile_information
    @current_user = User.find_by(emailadd: params[:emailadd])
    @emailadd = params[:emailadd]

	if !(@emailadd.nil?)
	  @password = @current_user.password
      @first_name = @current_user.first_name
      @last_name = @current_user.last_name
      @job_title = @current_user.job_title
      @phone = @current_user.phone
	
	  if(@job_title == "Admin")
	    @isAdmin = true
	  elsif(@job_title == "Secretary")
	    @isSecretary = true
	  else
	    @isOthers = true
	  end
	end
  end

  def edit_profile_information
    @current_user = User.find_by(emailadd: params[:emailadd])
    @emailadd = params[:emailadd]
	
	if !(@emailadd.nil?)
	  @jobtitle = Jobtitle.find_by_sql("SELECT * FROM jobtitles where name != '#{@current_user.job_title}'")
	  @password = @current_user.password
      @first_name = @current_user.first_name
      @last_name = @current_user.last_name
      @job_title =@current_user.job_title
      @phone = @current_user.phone
	
	  if(@job_title == "Admin")
	    @isAdmin = true
	  elsif(@job_title == "Secretary")
	    @isSecretary = true
	  else
	    @isOthers = true
	  end
	end
	
	flash[:notice] = "No changes were made!"
  end

  def update_profile_information
    current_user = User.find_by(emailadd: params[:emailadd])
	current_user.update(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])
	
	flash[:notice] = "Profile successfully updated!"
	redirect_to profile_information_path(emailadd: params[:emailadd])
  end

  def create_account
   @job_title = Jobtitle.all
  end

  def redirect_account
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @emailadd = params[:emailadd]
    @password = params[:password]
    @job_title = params[:job_title]
    @phone = params[:phone]
  
	@request = Request.new(:emailadd => @emailadd, :password => @password, :first_name => @first_name, :last_name => @last_name, :job_title => @job_title, :phone => @phone)
      
    if !(@request.save)
      flash[:error] = "Email already taken!"
	  redirect_to '/create_account'
    else
      flash[:success] = "Account registration sent to Admin!"
      redirect_to login_path
    end 
  end

  def delete_user
    current_user
    @user = User.find_by(emailadd: session[:current_user_emailadd])
	@google_user = User.find_by(emailadd: current_user.emailadd)
	
	User.delete(@user)
	User.delete(@google_user)

    flash[:success] = "Account was deleted successfully!"
    redirect_to '/'
  end
end
