class EventsController < ApplicationController
  
  def view_event
	@doc_id = params[:id]
	@document = Document.find(params[:id])
	@author = Author.find(params[:id])
	
	@events = Event.where(:doc_id => params[:id]).order(:event_date)
    @doc = Document.where(@doc_id)
  end
  
  def add_event
    @doc_id = params[:id]
	
	if params[:event] != nil
	  @events = Event.new(event_params)
	  if @events.save
	    @id = params[:doc_id]
	    @event = Event.find_by_sql("Select event_type, event_date from (Select event_type, max(event_date) as event_date from events where doc_id = #{@id})")
	    @doc_status = "#{@events.event_type}"
	    @doc_date = "#{@events.event_date}"
		doc = Document.find(params[:doc_id])
	    doc.update(date_modified: "#{@doc_date}", status: "#{@doc_status}")
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
    params.require(:event).permit(:event_date, :event_type, :remarks, :doc_id)
  end
  
end
