class DocumentsController < ApplicationController
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def view_documents
    @folders = Document.select(:doc_type).distinct
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

    @documents = Document.all
  end

  def add_document
    @folders = Document.select(:doc_type).distinct
    @doc_type = Doctype.all
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

	if params[:document] != nil
	  @documents = Document.new(user_params)
	  if @documents.save!
		if params[:author] != nil
	      @authors = Author.new(author_params)
	      @authors.save
	      author = Author.find(@documents.id)
	      doc = Document.find(@documents.id)
	      doc.update(author_name: author.name)
	    end

	    flash[:notice] = "The document was successfully added!"
	    redirect_to view_documents_path(emailadd: params[:emailadd])
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
	else
	  @isOthers = true
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
