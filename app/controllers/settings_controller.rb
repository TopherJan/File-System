class SettingsController < ApplicationController
  def settings
    @doc_type = Doctype.all
  end

  def add_doctype
    @typename = 'Name of the document type'
	
    if params[:doctype] != nil
	  @doc_type = Doctype.new(doctype_params)
	  
	  if !(@doc_type.save)
	     @typename = 'Name has already been taken. Please enter a unique name!'
	  else
	    redirect_to '/settings'
	  end
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
  
  def doctype_params
    params.require(:doctype).permit(:name)
  end
end