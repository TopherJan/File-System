class AttachmentsController < ApplicationController
  def view_file
    @doc_id = params[:id]
    @attachments = Attachment.where(doc_id: params[:id])
  end

  def upload_file
	@doc_id = params[:id]
    @attachment = Attachment.new
  end

  def save_file
    @attachment = Attachment.new(attachment_params)

    if @attachment.save
      redirect_to view_file_path(id: params[:doc_id]), notice: "The attachment #{@attachment.name} has been uploaded."
    else
      render "new"
    end
  end

  def delete_file
    @attachment = Attachment.find(params[:id])
	@doc_id = "#{@attachment.doc_id}"
    @attachment.destroy
    redirect_to view_file_path(id: "#{@doc_id}"), notice:  "The attachment has been deleted."
  end

private
  def attachment_params
    params.require(:attachment).permit(:name, :attachment, :doc_id)
  end
end
