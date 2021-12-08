class ApplicationController < ActionController::Base
  
  def home 
    render html: "Main page"
  end
  
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
