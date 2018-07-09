class FoldersController < ApplicationController
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def folders
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
    @folders = Document.select(:doc_type).distinct
  end
  
  def folder_year
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
	
    @doc_type = params[:doc_type]
	@doc_id = Document.select(:id).distinct.where(doc_type: params[:doc_type])
	@doc_year = Event.find_by_sql("SELECT DISTINCT strftime('%Y', event_date) as dates FROM events e JOIN documents d ON  e.event_date = d.date_modified where d.doc_type = '#{@doc_type}'")
  end
  
  def document_by_folder
    @doc_type = params[:doc_type]
	@date_given = params[:date_given]
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
	
	@document_type = Document.where(doc_type: params[:doc_type])
	@documents = Document.where("date_modified > ? and date_modified <= ? and doc_type = ?", Time.mktime("#{@date_given}",1,1,24), Time.mktime("#{@date_given}",12,31,24), "#{@doc_type}")
  end
  
end
