class LoginsController < ApplicationController

  attr_accessor :user, :dash
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def dashboard
    @countUser = User.count
    @countDocument = Document.count
    @countAttachment = Attachment.count
    @countEventToday = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @countDocumentToday = Document.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @countTransactions = @countEventToday.count + @countDocumentToday.count
	@requests = Request.all
	@users = User.all
	@attachments = Attachment.all
    @folders = Document.select(:doc_type).distinct
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
	session[:emailadd] = @emailadd
	
	@forwards = Forward.select(:doc_id).where(:user_id => "#{@user.id}", :status => 'FORWARDED')
	@received = Document.where(:id => @forwards)
	
	@settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
  end
  
  def receive_document
    forward = Forward.find_by(doc_id: params[:doc_id], user_id: params[:user_id])
	forward.update(:status => 'RECEIVED')
	
	@user = User.find(params[:user_id])
	@events = Event.new(event_date: DateTime.now.to_date, event_type: 'Acknowledged', remarks: "Acknowledged by #{@user.emailadd}", doc_id: params[:doc_id])
	
	if @events.save
	  @event = Event.where(doc_id: params[:doc_id]).order(event_date: :desc, created_at: :desc).first
	  @doc_status = "#{@event.event_type}"
	  @doc_date = "#{@event.event_date}"
	  doc = Document.find(params[:doc_id])
	  doc.update(date_modified: "#{@doc_date}", status: "#{@doc_status}")

	  flash[:notice] = "The document #{doc.name.upcase} has been RECEIVED!"
	  redirect_to dashboard_path(emailadd: session[:emailadd])
	end
  end
  
  def accept_request
    @request = Request.find_by(emailadd: params[:emailadd])
    @new_user = User.new(first_name: "#{@request.first_name}", last_name: "#{@request.last_name}",emailadd: "#{@request.emailadd}",password: "#{@request.password}",job_title: "#{@request.job_title}",phone: "#{@request.phone}")

    if(@new_user.save)
      Request.delete(@request)
      flash[:notice] = "The account request from #{@request.emailadd} was ACCEPTED!"
      redirect_to dashboard_path(emailadd: session[:emailadd])
    else
      flash[:danger] = "The email already exists! Delete #{@request.emailadd} request now!"
      redirect_to dashboard_path(emailadd: session[:emailadd])
    end
  end

  def delete_request
    @request = Request.find_by(emailadd: params[:emailadd])
    Request.delete(@request)

    flash[:danger] = "The account request from #{@request.emailadd} was REJECTED!"
    redirect_to dashboard_path(emailadd: session[:emailadd])
  end

  def log_user
    @emailadd = params[:emailadd]
    @password = params[:password]
    @user = User.find_by(emailadd: "#{@emailadd}")
	  @user_email = User.find_by(emailadd: "#{@emailadd}")

    if @user_email.nil?
	    flash[:danger] = "Incorrect email or password!"
      redirect_to '/login'
	  elsif (@user.nil?) || (@user.authenticate(@password) == false)
      flash[:danger] = "Incorrect email or password!"
      redirect_to '/login'
    else
      session[:user_id] = @user_email.id
      flash[:login] = "Successfully logged into the system!"
      redirect_to dashboard_path(emailadd: params[:emailadd])
    end
  end

  def create
    user = Request.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    @current_user = User.find_by(emailadd: user.emailadd)

    if @current_user.nil?
      redirect_to up_mail_path
    else
      @request = Request.find_by(emailadd: user.emailadd)
      Request.delete(@request)
      flash[:login] = "Successfully logged into the system!"
      redirect_to dashboard_path(emailadd: user.emailadd)
    end
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
