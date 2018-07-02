class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def confirm_logged_in
    unless session[:current_user_emailadd]
        flash[:warning] = "Please log in first."
        redirect_to :root
        return false
    else
        return true
    end
  end
end
