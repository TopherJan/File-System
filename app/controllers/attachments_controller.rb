class AttachmentsController < ApplicationController
  before_action :confirm_logged_in
  @isAdmin = false;
  @isSecretary = false;
  @isOthers = false;

  def upload_file
	@folders = Document.select(:doc_type).distinct
    @emailadd = params[:emailadd]
	@doc_id = params[:id]
    @attachment = Attachment.new
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
	  @doc = Forward.select(:doc_id).where(:user_id => "#{@user.id}")
	  @folders = Document.select(:doc_type).where(:id => "#{@doc}").distinct
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
