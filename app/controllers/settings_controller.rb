class SettingsController < ApplicationController

@isAdmin = false;
@isSecretary = false;
@isOthers = false;

  def settings
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
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
	
	@doc_type = Doctype.all
    @users = User.all
	@jobtitle = Jobtitle.all
  end

  def add_doctype
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
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

    if params[:doctype] != nil
	  @doc_type = Doctype.new(doctype_params)
		if !(@doc_type.save)
	  	  flash[:taken] = "Name has already been taken. Please enter a unique name!"
		else
		  flash[:notice] = "The document type #{@doc_type.name.upcase} was successfully ADDED!"
		  redirect_to settings_path(emailadd: params[:emailadd])
		end
	end
  end

  def delete_doctype
    @emailadd = params[:emailadd]
    @doc = Doctype.find(params[:id])
	flash[:notice] = "The document type #{@doc.name.upcase} was successfully DELETED!"
	Doctype.delete(@doc)
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def edit_doctype
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
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

    @doc_id = params[:id]
    @doctype = Doctype.find(params[:id])
	flash[:notice] = "The document type #{@doctype.name.upcase} was successfully UPDATED!"
  end

  def update_doctype
	@folders = Document.select(:doc_type).distinct
    doc = Doctype.find(params[:doctype_id])
	doc.update(name: params[:doctype_name])
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def add_jobtitle
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	else
	  @settings = false
	end
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
      @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end

    if params[:name] != nil
 	  @jobtitle = Jobtitle.new(name: params[:name], viewDocument: params[:viewDocument], addDocument: params[:addDocument], editDocument: params[:editDocument], deleteDocument: params[:deleteDocument], forwardDocument: params[:forwardDocument], addEvent: params[:addEvent], uploadFile: params[:uploadFile], deleteFile: params[:deleteFile], userRequest: params[:userRequest], jobtitleSettings: params[:jobtitleSettings], doctypeSettings: params[:doctypeSettings], userSettings: params[:userSettings])

      if !(@jobtitle.save)
        flash[:taken] = "Name has already been taken. Please enter a unique name!"
      else
        flash[:notice] = "The job title #{@jobtitle.name.upcase} was successfully ADDED!"
        redirect_to settings_path(emailadd: params[:emailadd])
      end
	end
  end

  def delete_jobtitle
    @emailadd = params[:emailadd]
    @job = Jobtitle.find(params[:id])
	flash[:notice] = "The job title #{@job.name.upcase}was successfully DELETED!"
	Jobtitle.delete(@job)
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def edit_jobtitle
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
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

    @job_id = params[:id]
    @jobtitle = Jobtitle.find(params[:id])
	flash[:notice] = "The job title #{@jobtitle.name.upcase} was successfully UPDATED!"
  end

  def update_jobtitle
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
    job = Jobtitle.find(params[:jobtitle_id])
	job.update(name: params[:jobtitle_name])
	redirect_to settings_path(emailadd: params[:emailadd])
  end

   def edit_users
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@current_user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
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

	session[:emailadd] = @emailadd
	@user_edit = User.find(params[:id])
	@jobtitle = Jobtitle.where.not(name: "#{@user_edit.job_title}")
	flash[:notice] = "User #{@user_edit.emailadd} successfully UPDATED!"
  end

  def update_users
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
    current_user = User.find_by(emailadd: params[:user_emailadd])
	current_user.update(job_title: params[:job_title])
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def delete_users
    @emailadd = params[:emailadd]
    @user = User.find(params[:id])
	User.delete(@user)

	flash[:notice] = "The user was successfully deleted!"
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def doctype_params
    params.require(:doctype).permit(:name)
  end
end
