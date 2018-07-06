class LoginsController < ApplicationController
attr_accessor :user, :dash

  def dashboard
    @countUser = User.count
    @countDocument = Document.count
    @countAttachment = Attachment.count
    @countEventToday = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @countDocumentToday = Document.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @countTransactions = @countEventToday.count + @countDocumentToday.count
	@requests = Request.all
	@documents =  Document.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
	@users = User.all
	@attachments = Attachment.all
	
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	session[:emailadd] = @emailadd
	@isAdmin = false;
	@isSecretary = false;
	@isOthers = false;
	
	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
  end
  
  def accept_request
    @request = Request.find_by(emailadd: params[:emailadd])
	
	@new_user = User.new(first_name: "#{@request.first_name}", last_name: "#{@request.last_name}",emailadd: "#{@request.emailadd}",password: "#{@request.password}",job_title: "#{@request.job_title}",phone: "#{@request.phone}")
	
	if(@new_user.save)
	  Request.delete(@request)
	  flash[:notice] = "The account request from #{@request.emailadd} was accepted!"
	  redirect_to dashboard_path(emailadd: session[:emailadd])
	else
	  flash[:danger] = "The email already exists! Delete #{@request.emailadd} request now!"
	  redirect_to dashboard_path(emailadd: session[:emailadd])
	end
  end
  
  def delete_request
    @request = Request.find_by(emailadd: params[:emailadd])
	Request.delete(@request)
	
	flash[:danger] = "The account request from #{@request.emailadd} was denied!"
	redirect_to dashboard_path(emailadd: session[:emailadd])
  end

  def log_user
	@emailadd = params[:emailadd]
	@password = params[:password]
	
	@user = User.find_by(emailadd: "#{@emailadd}", password: "#{@password}")

    if @user.nil?
	  flash[:danger] = "User does not exist! Try again!"
	  redirect_to '/'
	else
	  flash[:login] = "Successfully logged into the system!"
	  redirect_to dashboard_path(emailadd: params[:emailadd])
    end
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
	session[:user_id] = user.id
    flash[:login] = "Successfully logged in!"
    redirect_to view_documents_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_user_path
  end
  
  def logout
    session[:user_id] = nil
	reset_session
	flash[:notice] = "Logged out successfully!"
	redirect_to '/'
  end
  
end
