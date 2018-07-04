class FoldersController < ApplicationController

  def folders
    @folders = Document.select(:doc_type).distinct
  end
  
  def folder_year
    @doc_type = params[:doc_type]
	@doc_id = Document.select(:id).distinct.where(doc_type: params[:doc_type])
	@doc_year = Event.find_by_sql("SELECT DISTINCT strftime('%Y', event_date) as dates FROM events e JOIN documents d ON  e.event_date = d.date_modified where d.doc_type = '#{@doc_type}'")
  end
  
  def document_by_folder
    @doc_type = params[:doc_type]
	@date_given = params[:date_given]
	
	@document_type = Document.where(doc_type: params[:doc_type])
	#@documents = @document_type.find_by_sql("SELECT * from documents where strftime('%Y', date_modified) = #{@date_given}")
	@documents = Document.where("date_modified > ? and date_modified <= ? and doc_type = ?", Time.mktime("#{@date_given}",1,1,24), Time.mktime("#{@date_given}",12,31,24), "#{@doc_type}")
  end
  
end
