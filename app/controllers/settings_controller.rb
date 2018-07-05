class SettingsController < ApplicationController
  
  def settings
    @emailadd = params[:emailadd]
	
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
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
	
    @doc_type = Doctype.all
    @users = User.all
	@jobtitle = Jobtitle.all
  end

  def add_doctype
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
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
   
    if params[:doctype] != nil
	  @doc_type = Doctype.new(doctype_params)
	  if !(@doc_type.save)
	    flash[:taken] = "Name has already been taken. Please enter a unique name!"
	  else
	    flash[:notice] = "The document type was successfully added!"
	    redirect_to settings_path(emailadd: params[:emailadd])
	  end
	end
  end
  
  def delete_doctype
    @emailadd = params[:emailadd]
    @doc = Doctype.find(params[:id])
	Doctype.delete(@doc)
	
	flash[:danger] = "The document type was successfully deleted!"
	redirect_to settings_path(emailadd: params[:emailadd])
  end

  def edit_doctype
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
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
	
    @doc_id = params[:id]
    @doctype = Doctype.find(params[:id])
  end
  
  def update_doctype
    doc = Doctype.find(params[:doctype_id])
	doc.update(name: params[:doctype_name])
	
	flash[:notice] = "The document type was successfully updated!"
	redirect_to settings_path(emailadd: params[:emailadd])
  end
  
  def add_jobtitle
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
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

    if params[:name] != nil
	  @jobtitle = Jobtitle.new(name: params[:name])
	  
	  if !(@jobtitle.save)
	    flash[:taken] = "Name has already been taken. Please enter a unique name!"
	  else
	    flash[:notice] = "The job title was successfully added!"
	    redirect_to settings_path(emailadd: params[:emailadd])
	  end
	end
  end
  
  def delete_jobtitle
    @emailadd = params[:emailadd]
    @job = Jobtitle.find(params[:id])
	Jobtitle.delete(@job)
	
	flash[:danger] = "The job title was successfully deleted!"
	redirect_to settings_path(emailadd: params[:emailadd])
  end
  
  def edit_jobtitle
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
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
	
    @job_id = params[:id]
    @jobtitle = Jobtitle.find(params[:id])
  end
  
  def update_jobtitle
    @emailadd = params[:emailadd]
    job = Jobtitle.find(params[:jobtitle_id])
	job.update(name: params[:jobtitle_name])
	
	flash[:notice] = "The job title was successfully updated!"
	redirect_to settings_path(emailadd: params[:emailadd])
  end
  
  def doctype_params
    params.require(:doctype).permit(:name)
  end
end