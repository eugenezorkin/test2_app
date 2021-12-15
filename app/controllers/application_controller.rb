class ApplicationController < ActionController::Base
  
  around_action :switch_locale
  
  
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
  
  
  def home
    
    render html: "Main page"
    
    #User.create(email: "test12@test.ru", name: "test12")
    
  end
  
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end
end
