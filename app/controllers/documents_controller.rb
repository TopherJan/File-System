class DocumentsController < ApplicationController
  before_action :confirm_logged_in
  
  def view_documents
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@folders = Document.select(:doc_type).distinct
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
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end
  end

  def add_document
    @folders = Document.select(:doc_type).distinct
    @doc_type = Doctype.all
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@attachment = Attachment.new
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
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end

	if params[:document] != nil
	  @documents = Document.new(user_params)
	  if @documents.save!
	    @doc_id = @documents.id
		if params[:author] != nil
	      @authors = Author.new(author_params)
	      @authors.save
		  
		  @event = Event.new(doc_id: "#{@documents.id}", remarks: "Added by #{@emailadd}", event_date: DateTime.now.to_date, event_type: "Added")
		  @event.save
		  
		  @events = Event.new(doc_id: "#{@documents.id}", event_type: params[:event_type], event_date: params[:event_date], remarks: params[:event_remarks])
		  @events.save
		  
		  doc = Document.find(@documents.id)
	      doc.update(author_name: "#{@authors.name}", date_modified: "#{@events.event_date}", status: "#{@events.event_type}")
	    end
		
		if(params[:save_and_upload])
	      redirect_to upload_file_path(id: "#{@documents.id}", emailadd: "#{@emailadd}")
		else
	      flash[:notice] = "The document was successfully ADDED!"
	      redirect_to view_documents_path(emailadd: params[:emailadd])
		end
	  end
	end
  end

  def edit_document_view
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
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end

    session[:emailadd] = params[:emailadd]
    @doc_id = params[:id]
    @doc = Document.find(params[:id])
    @author = Author.find(params[:id])
    #@doc_type = Doctype.find_by_sql("SELECT * FROM doctypes where name != '#{@doc.doc_type}'")
    @doc_type = Doctype.where.not(name: @doc.doc_type)
	
	flash[:notice] = "The document #{@doc.name.upcase} was successfully UPDATED!"
  end

  def update_document
	@emailadd = params[:emailadd]
    @events = Event.new(doc_id: params[:document_id], remarks: "Edited by #{@emailadd}", event_date: DateTime.now.to_date, event_type: "Updated")
    
	if @events.save
      @event = Event.where(doc_id: params[:document_id]).order(event_date: :desc, created_at: :desc).first
      @doc_status = "#{@event.event_type}"
      @doc_date = "#{@event.event_date}"
      doc = Document.find(params[:document_id])
      doc.update(date_modified: "#{@doc_date}", status: "#{@doc_status}")
	end
    
	@folders = Document.select(:doc_type).distinct
    author = Author.find(params[:document_id])
    author.update(name: params[:author_name], contact: params[:author_contact], department: params[:author_department], agency: params[:author_agency], address: params[:author_address])
    doc = Document.find(params[:document_id])
    doc.update(name: params[:document_name], doc_type: params[:document_type], description: params[:document_description], location: params[:document_location], author_name: params[:author_name])

    redirect_to view_documents_path(emailadd: params[:emailadd])
  end

  def delete_document
    @emailadd = params[:emailadd]
    @doc = Document.find(params[:id])
    @author = Author.find(params[:id])
    event = Event.where(:doc_id => params[:id])
    attachment = Attachment.where(:doc_id => params[:id])
	forward = Forward.where(:doc_id => params[:id])

    flash[:notice] = "The document #{@doc.name.upcase} was successfully DELETED!"

    Document.delete(@doc)
    Author.delete(@author)
    Event.delete(event)
    Attachment.delete(attachment)
	Forward.delete(forward)

    redirect_to session.delete(:return_to)
  end

  def user_params
    params.require(:document).permit(:name, :description, :location, :doc_type, :user_id)
  end

  def author_params
    params.require(:author).permit(:name, :contact, :department, :agency, :address)
  end

  def event_params
    params.require(:event).permit(:doc_id, :event_date, :event_type, :remarks)
  end

end
