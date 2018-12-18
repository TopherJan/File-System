class AttachmentsController < ApplicationController
  before_action :confirm_logged_in

  def upload_file
    @folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
    @doc_id = params[:id]
    @attachment = Attachment.new
  	@user = User.find_by(emailadd: params[:emailadd])
    @job = Jobtitle.find_by(:name => "#{@user.job_title}")
    @settings = false
	
	if(@job.jobtitleSettings || @job.doctypeSettings || @job.userSettings)
	  @settings = true
	end
	
	if(params[:notif_status])
	  @notif = Notification.where(id: params[:notif_id])
	  @notif.update(status: true)
	end
	
	@notifications = Notification.where(user_id: "#{@user.id}", status: false)
	@countNotif = @notifications.count
	
	if(@job.viewDocument)
	  @documents = Document.all
	else
      @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @doc1 = Document.where(user_id: "#{@user.id}")
	  @doc2 = Document.where(:id => @doc).order(:date_modified)
	  @documents = @doc1 + @doc2
	end
  end

  def save_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
	  flash[:notice] = "The file was successfuly ADDED!"
      redirect_to view_event_path(id: params[:doc_id], emailadd: params[:emailadd])
    end
  end

  def delete_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.find(params[:id])
    @doc_id = "#{@attachment.doc_id}"
    @attachment.destroy
	flash[:notice] = "The file was successfuly DELETED!"
    redirect_to view_event_path(id: "#{@doc_id}", emailadd: params[:emailadd])
  end

private
  def attachment_params
    params.require(:attachment).permit(:attachment, :doc_id)
  end
end
