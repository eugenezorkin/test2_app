class StaticPagesController < ApplicationController
  def home
    
    
    @firsttitle = User.first.news.first.title;
    
  end
end
