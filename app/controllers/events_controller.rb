class EventsController < ApplicationController
  
  def view_event
	@doc_id = params[:id]
	document = Document.find(@doc_id)
	@events = Event.where(:doc_id => params[:id])
    @doc = Document.where(@doc_id)
 	author = Author.find(params[:id])
	
	@doc_name = document.name
	@doc_location = document.location
	@doc_type = document.doc_type
	@author_name = author.name
  end
  
  def add_event
    @doc_id = params[:id]
	
	if params[:event] != nil
	  @events = Event.new(event_params)
	  if @events.save      
        flash[:success] = "Event added!"
		redirect_to '/view_documents'
	  end
	else
	  @events = Event.all
	end
  end
  
  def event_params
    params.require(:event).permit(:date, :event_type, :remarks, :doc_id)
  end
  
end
