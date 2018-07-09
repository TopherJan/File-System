class EventsController < ApplicationController
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def view_event
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

	@doc_id = params[:id]
	@document = Document.find(params[:id])
	@author = Author.find(params[:id])
	@events = Event.where(:doc_id => params[:id]).order(:event_date)
    @doc = Document.where(@doc_id)
  end

  def add_event
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@doc_id = params[:id]
	@job_title = "#{@user.job_title}"

	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end

	if params[:event] != nil
	  @events = Event.new(event_params)
	  if @events.save
	    @id = params[:doc_id]
	    @event = Event.where(doc_id: params[:doc_id])
		@event_update = @event.order(event_date: :desc).first
	    @doc_status = "#{@event_update.event_type}"
	    @doc_date = "#{@event_update.event_date}"
		doc = Document.find(params[:doc_id])
	    doc.update(date_modified: "#{@doc_date}", status: "#{@doc_status}")

		flash[:notice] = "The event was successfully added!"
		redirect_to view_event_path(id: params[:doc_id], emailadd: params[:emailadd])
	  end
	end
  end

  def event_params
    params.require(:event).permit(:event_date, :event_type, :remarks, :doc_id)
  end

end
