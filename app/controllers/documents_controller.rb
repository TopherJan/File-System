class DocumentsController < ApplicationController

  def add_document
    if params[:document] != nil
	  @documents = Document.new(user_params)
	  doc = params[:id]
	  session[:passed_variable] = doc
	  if @documents.save      
        flash[:success] = "Document added!"
	    add_author
	  end
	end
  end
  
  def add_author
    @first_value = session[:passed_variable] 
    @get_value = @first_value
	
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
  
  def user_params
    params.require(:document).permit(:name, :description, :location, :doc_type)
  end
  
  def author_params
	params.require(:author).permit(:name, :contact, :department, :agency, :address, session[:passed_variable])
  end
  
end
