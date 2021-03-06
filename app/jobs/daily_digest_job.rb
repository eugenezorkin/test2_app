class DailyDigestJob < ApplicationJob
  #queue_as :core
  #self.queue_adapter = :resque
  #queue_as :core
  @queue = :main

  def perform(*args)
    
    @start_date = (Date.today - 1.day).beginning_of_day
    @end_date   = (Date.today - 1.day).end_of_day
    @dailydigest_news = News.where("created_at > ? AND created_at < ?", @start_date, @end_date);
    @dailydigest_users = User.where(:digest=>:dayly)
    
    if @dailydigest_news.count > 0 && @dailydigest_users.count >0
      @dailydigest_users.each do |dailydigest_user|
        NewsMailer.dailydigest_email(dailydigest_user,@dailydigest_news).deliver_now
      end
    end
  end
  
end
