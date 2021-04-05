class ApplicationController < ActionController::Base
    
  helper_method(:current_user)

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login
    ((flash[:message] = "You must be logged in to do this") && (redirect_to '/login')) if !current_user
  end

end
