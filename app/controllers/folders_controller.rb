class FoldersController < ApplicationController
	before_filter :confirm_logged_in
	@isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def folders
    @folders = Document.select(:doc_type).distinct
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"

	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	elsif(@job_title == "Dean")
	  @isOthers = true
	else
      @isOthers = true
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
	end
  end

  def folder_year
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	elsif(@job_title == "Dean")
	  @isOthers = true
	else
	  @isOthers = true
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
	end

    @doc_type = params[:doc_type]
	@doc_id = Document.select(:id).distinct.where(doc_type: params[:doc_type])
	@doc_year = Event.find_by_sql("SELECT DISTINCT date_part('year', event_date) as dates FROM events e JOIN documents d ON  e.event_date = d.date_modified where d.doc_type = '#{@doc_type}'")
  end

  def document_by_folder
    @folders = Document.select(:doc_type).distinct
    @doc_type = params[:doc_type]
	@date_given = params[:date_given]
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"

	if(@job_title == "Admin")
	  @isAdmin = true
	  @documents = Document.all
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	  @documents = Document.all
	elsif(@job_title == "Dean")
	  @isOthers = true
	  @documents = Document.all
	else
      @isOthers = true
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
	end

	@document_type = Document.where(doc_type: params[:doc_type])
	@documents = Document.where("date_modified > ? and date_modified <= ? and doc_type = ?", Time.mktime("#{@date_given}",1,1,24), Time.mktime("#{@date_given}",12,31,24), "#{@doc_type}")
  end

end
