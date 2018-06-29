class DocumentsController < ApplicationController

  def add_document
    if params[:document] != nil
	  @documents = Document.new(user_params)
	  doc = params[:id]
	  if @documents.save!      
        flash[:success] = "Document added!"
	    add_author
	  end
	end
  end
  
  def edit_document_view
	@doc_id = params[:id]
	@doc = Document.find(params[:id])
	@author = Author.find(params[:id])
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
	  @authors.save!
	end
	
	redirect_to '/view_documents'
  end
  
  def view_documents
    @authors = Author.all
    @documents = Document.all
  end
  
  def delete_document
    @doc = Document.find(params[:id])
	@author = Author.find(params[:id])
	event = Event.where(:doc_id => params[:id])
	
	Document.delete(@doc)
	Author.delete(@author)
	Event.delete(event.ids)
	
	redirect_to '/view_documents'
  end
  
  def user_params
    params.require(:document).permit(:name, :description, :location, :doc_type)
  end
  
  def author_params
	params.require(:author).permit(:name, :contact, :department, :agency, :address)
  end
  
end
