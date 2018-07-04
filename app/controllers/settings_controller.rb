class SettingsController < ApplicationController
  def settings
    @doc_type = Doctype.all
  end

  def add_doctype

    if params[:doc_type_name] != nil
	  @doctype = Doctype.create!(name: params[:doc_type_name])
      redirect_to '/settings'
	end
  end
  
  def delete_doctype
    @doc = Doctype.find(params[:id])
	Doctype.delete(@doc)
	
	redirect_to '/settings'
  end

  def edit_doctype
    @doc_id = params[:id]
    @doctype = Doctype.find(params[:id])
  end
  
  def update_doctype
    doc = Doctype.find(params[:doctype_id])
	doc.update(name: params[:doctype_name])
	
	redirect_to '/settings'
  end
end