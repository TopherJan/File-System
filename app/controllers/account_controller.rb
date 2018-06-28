class AccountController < ApplicationController


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
