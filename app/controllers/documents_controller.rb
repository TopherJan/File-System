class DocumentsController < ApplicationController

  def add_document
    @doc_type = Doctype.all
    
	if params[:document] != nil
	  @documents = Document.new(user_params)
	  
	  if @documents.save!      
        flash[:success] = "Document added!"
		@doc = @documents.id
        session[:doc_id] = @doc
	    add_author
	  end
	end
  end
  
  def edit_document_view
	@doc_id = params[:id]
	@doc = Document.find(params[:id])
	@author = Author.find(params[:id])
	@doc_type = Doctype.find_by_sql("SELECT * FROM doctypes where name != '#{@doc.doc_type}'")
	
  end
  
  def update_document
    doc = Document.find(params[:document_id])
	doc.update(name: params[:document_name], doc_type: params[:document_type], description: params[:document_description], location: params[:document_location])
	author = Author.find(params[:document_id])
	author.update(name: params[:author_name], contact: params[:author_contact], department: params[:author_department], agency: params[:author_agency], address: params[:author_address])
	redirect_to '/view_documents'
  end
  
  def add_author
    if params[:author] != nil
	  @authors = Author.new(author_params)
	  @authors.save
	  
	  author = Author.find(session[:doc_id])
	  doc = Document.find(session[:doc_id])
	  doc.update(author_name: author.name)
	end
	
	redirect_to '/view_documents'
  end
  
  def view_documents
    @documents = Document.all
  end
  
  def delete_document
    @doc = Document.find(params[:id])
	@author = Author.find(params[:id])
	event = Event.where(:doc_id => params[:id])
	
	Document.delete(@doc)
	Author.delete(@author)
	Event.delete(event)
	
	redirect_to '/view_documents'
  end
  
  def folders
    @folders = Document.select(:doc_type).distinct
  end
  
  def folder_year
    @doc_type = params[:doc_type]
	@doc_id = Document.select(:id).distinct.where(doc_type: params[:doc_type])
	@doc_year = Event.find_by_sql("SELECT DISTINCT strftime('%Y', event_date) as dates FROM events e JOIN documents d ON  e.event_date = d.date_modified where d.doc_type = '#{@doc_type}'")
  end
  
  def document_by_folder
    @doc_type = params[:doc_type]
	@date_given = params[:date_given]
	@documents = Document.where("date_modified >= ? and date_modified < ? and doc_type = ?", Time.mktime("#{@date_given}",1), Time.mktime("#{@date_given}",12), "#{@doc_type}")
  end
  
  def user_params
    params.require(:document).permit(:name, :description, :location, :doc_type, attachments_attributes: [:attachment, :doc_id])
  end
  
  def author_params
	params.require(:author).permit(:name, :contact, :department, :agency, :address)
  end
  
  def event_params
	params.require(:event).permit(:doc_id, :event_date, :event_type, :remarks)
  end
  
end
	