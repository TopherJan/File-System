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
	elsif(@job_title == "Dean")
	  @isOthers = true
	else
	  @isOthers = true
	  doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => doc).distinct
	end

	@doc_id = params[:id]
	@document = Document.find(params[:id])
	@author = Author.find(params[:id])
	@events = Event.where(:doc_id => params[:id]).order(:event_date)
    @doc = Document.where(@doc_id)
	@attachments = Attachment.where(doc_id: params[:id])
  end
  
  def forward
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"
	
	@forw = Forward.select(:user_id).where(:doc_id => params[:id])
	@users = User.where.not(:id => @user.id).where.not(:id => @forw)
	@sent = User.where.not(:id => @user.id).where(:id => @forw)
	@status = Forward.select(:status).where(user_id: @sent.ids).where(doc_id: params[:id])

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
	
	@doc_id = params[:id]
	@document = Document.find(params[:id])
	@author = Author.find(params[:id])
  end
  
  def send_document
    @emailadd = params[:emailadd]
	@forward = Forward.new(user_id: params[:user_id], doc_id: params[:doc_id], status: 'FORWARDED')
	@user = User.find(params[:user_id])
	
	if @forward.save
	  @events = Event.new(event_date: DateTime.now.to_date, event_type: 'Forwarded', remarks: "#{@user.emailadd}", doc_id: params[:doc_id])
	  if @events.save
		@event = Event.where(doc_id: params[:doc_id]).order(event_date: :desc, created_at: :desc).first
	    @doc_status = "#{@event.event_type}"
	    @doc_date = "#{@event.event_date}"
		doc = Document.find(params[:doc_id])
	    doc.update(date_modified: "#{@doc_date}", status: "#{@doc_status}")

        flash[:notice] = "The document was successfully sent to #{@user.emailadd}!"
	    redirect_to forward_path(id: params[:doc_id], emailadd: "#{@emailadd}")
	  end
	end
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
	elsif(@job_title == "Dean")
	  @isOthers = true
	else
	  @isOthers = true
	  doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => doc).distinct
	end

	if params[:event] != nil
	  @events = Event.new(event_params)
	  if @events.save
	    @id = params[:doc_id]
	    @event = Event.where(doc_id: params[:doc_id]).order(event_date: :desc, created_at: :desc).first
	    @doc_status = "#{@event.event_type}"
	    @doc_date = "#{@event.event_date}"
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
