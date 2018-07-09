class AttachmentsController < ApplicationController
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def view_file
    @emailadd = params[:emailadd]
    @doc_id = params[:id]
    @attachments = Attachment.where(doc_id: params[:id])
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"

	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
  end

  def upload_file
    @emailadd = params[:emailadd]
	@doc_id = params[:id]
    @attachment = Attachment.new
	@user = User.find_by(emailadd: params[:emailadd])
	@job_title = "#{@user.job_title}"

	if(@job_title == "Admin")
	  @isAdmin = true
	elsif(@job_title == "Secretary")
	  @isSecretary = true
	else
	  @isOthers = true
	end
  end

  def save_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
	  flash[:file] = "The file was successfuly added!"
      redirect_to view_event_path(id: params[:doc_id], emailadd: params[:emailadd])
    end
  end

  def delete_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.find(params[:id])
	@doc_id = "#{@attachment.doc_id}"
    @attachment.destroy
	flash[:file] = "The file was successfuly deleted!"
    redirect_to view_event_path(id: "#{@doc_id}", emailadd: params[:emailadd])
  end

private
  def attachment_params
    params.require(:attachment).permit(:attachment, :doc_id)
  end
end
