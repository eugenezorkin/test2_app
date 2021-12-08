class StaticPagesController < ApplicationController
  def home
    
    
    @firsttitle = User.first.news.first.title;
    if user_signed_in?
      @curusername = current_user.email
      @isId1 = current_user.role?;
    else 
      @curusername = "no logged user";
      @isId1 = "no id";
    end;
    
    @islogged = user_signed_in?;
    
    

  end
end
