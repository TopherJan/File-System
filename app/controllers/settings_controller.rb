class SettingsController < ApplicationController
  
  def settings
    @emailadd = params[:emailadd]
    @doc_type = Doctype.all
    @users = User.all
	@jobtitle = Jobtitle.all
  end

  def add_doctype
    if params[:doctype] != nil
	  @doc_type = Doctype.new(doctype_params)
	  
	  if !(@doc_type.save)
	    flash[:taken] = "Name has already been taken. Please enter a unique name!"
	  else
	    flash[:notice] = "The document type was successfully added!"
	    redirect_to '/settings'
	  end
	end
  end
  
  def delete_doctype
    @doc = Doctype.find(params[:id])
	Doctype.delete(@doc)
	
	flash[:danger] = "The document type was successfully deleted!"
	redirect_to '/settings'
  end

  def edit_doctype
    @doc_id = params[:id]
    @doctype = Doctype.find(params[:id])
	
	#flash[:notice] = "No changes were made in document type!"
  end
  
  def update_doctype
    doc = Doctype.find(params[:doctype_id])
	doc.update(name: params[:doctype_name])
	
	flash.keep[:notice] = "The document type was successfully updated!"
	redirect_to '/settings'
  end
  
  def add_jobtitle
    if params[:name] != nil
	  @jobtitle = Jobtitle.new(name: params[:name])
	  
	  if !(@jobtitle.save)
	    flash[:taken] = "Name has already been taken. Please enter a unique name!"
	  else
	    flash[:notice] = "The job title was successfully added!"
	    redirect_to '/settings'
	  end
	end
  end
  
  def delete_jobtitile
    @job = Jobtitle.find(params[:id])
	Jobtitle.delete(@job)
	
	flash[:danger] = "The document type was successfully deleted!"
	redirect_to '/settings'
  end
  
  def edit_jobtitle
    @job_id = params[:id]
    @jobtitle = Jobtitle.find(params[:id])
	
	#flash[:notice] = "No changes were made in job title!"
  end
  
  def update_jobtitle
    job = Jobtitle.find(params[:jobtitle_id])
	job.update(name: params[:jobtitle_name])
	
	flash[:notice] = "The job title was successfully updated!"
	redirect_to '/settings'
  end
  
  def doctype_params
    params.require(:doctype).permit(:name)
  end
end