class SettingsController < ApplicationController
  def settings
    @emailadd = params[:emailadd]
    @doc_type = Doctype.all
    @users = User.all
  end

  def add_doctype
    if params[:doctype] != nil
	  @doc_type = Doctype.new(doctype_params)
	  
	  if !(@doc_type.save)
	    flash[:danger] = 'Name has already been taken. Please enter a unique name!'
	  else
	    flash[:notice] = 'The document type was successfully added!'
	    redirect_to '/settings'
	  end
	end
  end
  
  def delete_doctype
    @doc = Doctype.find(params[:id])
	Doctype.delete(@doc)
	
	flash[:danger] = 'The document type was successfully deleted!'
	redirect_to '/settings'
  end

  def edit_doctype
    @doc_id = params[:id]
    @doctype = Doctype.find(params[:id])
  end
  
  def update_doctype
    doc = Doctype.find(params[:doctype_id])
	doc.update(name: params[:doctype_name])
	
	flash[:notice] = 'The document type was successfully updated!'
	redirect_to '/settings'
  end
  
  def doctype_params
    params.require(:doctype).permit(:name)
  end
end