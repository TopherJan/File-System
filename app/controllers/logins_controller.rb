class LoginsController < ApplicationController


  def login

  end

def dashboard

   @countUser = User.count
   @countDocument = Document.count
   @countAttachment = Attachment.count
   @countEventToday = Event.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
   @countDocumentToday = Document.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
   @countTransactions = @countEventToday.count + @countDocumentToday.count

end

def log_user
		@emailadd = params[:emailadd]
		@password = params[:password]

		@user = User.where("emailadd = ? AND password = ?", @emailadd, @password)


		if @user.empty?
			flash[:warning] = "USER DOES NOT EXIST! TRY AGAIN!"
			redirect_to '/'
		else
			flash[:notice] = "LOGIN SUCCESSFUL!"
			session[:current_user_emailadd] = @emailadd
			session[:current_user_password] = @password
			redirect_to controller: "documents", action: "view_documents"
		end
	end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to view_documents_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_user_path
  end
  def logout
    session[:user_id] = nil
		reset_session
		redirect_to '/'
	end

end
