class ApplicationController < ActionController::Base
  
  def home
    
    render html: "Main page"
    
    #User.create(email: "test12@test.ru", name: "test12")
    
  end
  
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
