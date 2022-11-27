class ApplicationController < ActionController::Base
  

  def after_sign_in_path_for(resource)
     flash[:in] = 'Signed in successfully.'
    user_path(current_user)
  end


  
  def after_sign_out_path_for(resource)
    flash[:out] = 'Signed out successfully.'
    root_path
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
