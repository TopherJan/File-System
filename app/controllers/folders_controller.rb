class FoldersController < ApplicationController
	before_action :confirm_logged_in

  def folders
    @folders = Document.select(:doc_type).distinct
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(params[:notif_status])
	  @notif = Notification.where(id: params[:notif_id])
	  @notif.update(status: true)
	end
	
	@notifications = Notification.where(user_id: "#{@user.id}", status: false)
	@countNotif = @notifications.count
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	end
  end

  def folder_year
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(params[:notif_status])
	  @notif = Notification.where(id: params[:notif_id])
	  @notif.update(status: true)
	end
	
	@notifications = Notification.where(user_id: "#{@user.id}", status: false)
	@countNotif = @notifications.count
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
	end
	
    @doc_type = params[:doc_type]
	@doc_id = Document.select(:id).distinct.where(doc_type: params[:doc_type])
#	joined_event_doc = Event.joins("JOIN documents ON events.event_date = documents.date_modified")
#	joined_event_doc = joined_event_doc.where(doc_type: @doc_type).uniq;
#	@doc_year = joined_event_doc.to_date.year
	@doc_year = Event.find_by_sql("SELECT DISTINCT date_part('year', event_date) as dates FROM events e JOIN documents d ON  e.event_date = d.date_modified where d.doc_type = '#{@doc_type}'")
		
	end

  def document_by_folder
    @folders = Document.select(:doc_type).distinct
    @doc_type = params[:doc_type]
	@date_given = params[:date_given]
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job = Jobtitle.find_by(:name => "#{@user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(params[:notif_status])
	  @notif = Notification.where(id: params[:notif_id])
	  @notif.update(status: true)
	end
	
	@notifications = Notification.where(user_id: "#{@user.id}", status: false)
	@countNotif = @notifications.count
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
      @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @doc1 = Document.where(user_id: "#{@user.id}", doc_type: "#{@doc_type}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end

	@document_type = Document.where(doc_type: params[:doc_type])
	#@documents = Document.where("date_modified > ? and date_modified <= ? and doc_type = ?", Time.mktime("#{@date_given}",1,1,24), Time.mktime("#{@date_given}",12,31,24), "#{@doc_type}")
  end

end
