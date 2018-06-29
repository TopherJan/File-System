class EventsController < ApplicationController
  
  def view_event
	@doc_id = params[:id]
	@document = Document.find(params[:id])
	@author = Author.find(params[:id])
	
	@events = Event.where(:doc_id => params[:id])
    @doc = Document.where(@doc_id)
  end
  
  def add_event
    @doc_id = params[:id]
	
	if params[:event] != nil
	  @events = Event.new(event_params)
	  if @events.save    
        flash[:success] = "Event added!"
		redirect_to view_event_path(id: params[:doc_id])
	  end
	end
  end
  
  def update_event
	if params[:event] != nil
	  @events = Event.new(event_params)
	  @events.save!
      flash[:success] = "Event added!"
	end
  end
  def event_params
    params.require(:event).permit(:date, :event_type, :remarks, :doc_id)
  end
  
end
