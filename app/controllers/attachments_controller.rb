class AttachmentsController < ApplicationController
  
  def view_file
    @emailadd = params[:emailadd]
    @doc_id = params[:id]
    @attachments = Attachment.where(doc_id: params[:id])
  end

  def upload_file
    @emailadd = params[:emailadd]
	@doc_id = params[:id]
    @attachment = Attachment.new
  end

  def save_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
	  flash[:notice] = "The file was successfuly added!"
      redirect_to view_file_path(id: params[:doc_id], emailadd: params[:emailadd])
    end
  end

  def delete_file
    @emailadd = params[:emailadd]
    @attachment = Attachment.find(params[:id])
	@doc_id = "#{@attachment.doc_id}"
    @attachment.destroy
	
	flash[:danger] = "The file was successfuly deleted!"
    redirect_to view_file_path(id: "#{@doc_id}", emailadd: params[:emailadd])
  end

private
  def attachment_params
    params.require(:attachment).permit(:attachment, :doc_id)
  end
end
