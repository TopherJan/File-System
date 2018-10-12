class AccountController < ApplicationController
  skip_before_action :verify_authenticity_token
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def profile_information
    @folders = Document.select(:doc_type).distinct
    @current_user = User.find_by(emailadd: params[:emailadd])
    @emailadd = params[:emailadd]
	
	@job = Jobtitle.find_by(:name => "#{@current_user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
      @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end
  end

  def edit_profile_information
    @folders = Document.select(:doc_type).distinct
    @current_user = User.find_by(emailadd: params[:emailadd])
    @emailadd = params[:emailadd]
    
	@job = Jobtitle.find_by(:name => "#{@current_user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
      @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end

    flash[:notice] = "No changes were made!"
  end

  def update_profile_information
    current = User.find_by(emailadd: params[:emailadd])
    current.update!(first_name: params[:first_name], last_name: params[:last_name], job_title: params[:job_title], phone: params[:phone])

    flash[:notice] = "Profile successfully updated!"
    redirect_to profile_information_path(emailadd: params[:emailadd])
  end

  def create_account
    @job_title = Jobtitle.all
  end

  def up_mail
    @job_title = Jobtitle.all
  end


  def redirect_account
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @emailadd = params[:emailadd]
    @password = params[:password]
    @job_title = params[:job_title]
    @phone = params[:phone]


    if !current_user
      #@request = Request.new(:emailadd => @emailadd, :password_ => @password, :first_name => @first_name, :last_name => @last_name, :job_title => @job_title, :phone => @phone)
      @request = Request.new(user_params)
      if !(@request.save)
        flash[:error] = "Email already taken!"
        redirect_to '/create_account'
      else
        flash[:success] = "Account registration sent to Admin!"
        redirect_to login_path
      end

    else
      request = Request.find_by(:emailadd => current_user.emailadd)
      request.update(job_title: "#{@job_title}", phone: "#{@phone}")
      flash[:success] = "Account registration sent to Admin!"
	  session[:user_id] = nil
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

  private

  def user_params
    user = params
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.permit(:first_name,:last_name,:emailadd, :password, :password_confirmation, :job_title, :phone)
  end

end
