class DocumentsController < ApplicationController
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def view_documents
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	@folders = Document.select(:doc_type).distinct
	if(@job_title == "Admin")
	  @isAdmin = true
	  @documents = Document.order(date_modified: :desc).all
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	  @documents = Document.all.order(:date_modified)
	elsif(@job_title == "Dean")
	  @isOthers = true
	  @documents = Document.all.order(:date_modified)
	else
	  @isOthers = true
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @documents = Document.where(:id => doc).order(:date_modified)
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
	end
  end

  def add_document
    @folders = Document.select(:doc_type).distinct
    @doc_type = Doctype.all
	@emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	@attachment = Attachment.new

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

	if params[:document] != nil
	  @documents = Document.new(user_params)
	  if @documents.save!
	    @doc_id = @documents.id
		if params[:author] != nil
	      @authors = Author.new(author_params)
	      @authors.save
		  
		  @events = Event.new(doc_id: "#{@documents.id}", event_type: params[:event_type], event_date: params[:event_date], remarks: params[:event_remarks])
		  @events.save
		  
		  doc = Document.find(@documents.id)
	      doc.update(author_name: "#{@authors.name}", date_modified: "#{@events.event_date}", status: "#{@events.event_type}")
	    end
		
		if(params[:save_and_upload])
	      redirect_to upload_file_path(id: "#{@documents.id}", emailadd: "#{@emailadd}")
		else
	      flash[:notice] = "The document was successfully added!"
	      redirect_to view_documents_path(emailadd: params[:emailadd])
		end
	  end
	end
  end

  def edit_document_view
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

    session[:emailadd] = params[:emailadd]
    @doc_id = params[:id]
    @doc = Document.find(params[:id])
    @author = Author.find(params[:id])
    @doc_type = Doctype.find_by_sql("SELECT * FROM doctypes where name != '#{@doc.doc_type}'")
  end

  def update_document
    @folders = Document.select(:doc_type).distinct
    author = Author.find(params[:document_id])
    author.update(name: params[:author_name], contact: params[:author_contact], department: params[:author_department], agency: params[:author_agency], address: params[:author_address])
    doc = Document.find(params[:document_id])
    doc.update(name: params[:document_name], doc_type: params[:document_type], description: params[:document_description], location: params[:document_location], author_name: params[:author_name])

    flash[:notice] = "The document was successfully updated!"
    redirect_to view_documents_path(emailadd: params[:emailadd])
  end

  def delete_document
    @emailadd = params[:emailadd]
    @doc = Document.find(params[:id])
    @author = Author.find(params[:id])
    event = Event.where(:doc_id => params[:id])
    attachment = Attachment.where(:doc_id => params[:id])

    Document.delete(@doc)
    Author.delete(@author)
    Event.delete(event)
    Attachment.delete(attachment)

    session[:return_to] ||= request.referer
    flash[:notice] = "The document was successfully deleted!"
    redirect_to session.delete(:return_to)
  end

  def user_params
    params.require(:document).permit(:name, :description, :location, :doc_type)
  end

  def author_params
    params.require(:author).permit(:name, :contact, :department, :agency, :address)
  end

  def event_params
    params.require(:event).permit(:doc_id, :event_date, :event_type, :remarks)
  end

end
