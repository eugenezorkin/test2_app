class ApplicationController < ActionController::Base
  
  def home 
    render html: "Main page"
  end
end
