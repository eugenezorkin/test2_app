class DailyDigestJob #< ApplicationJob
  #queue_as :core
  #self.queue_adapter = :resque
  #queue_as :core
  @queue = :core

  def perform(*args)
    
    my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    my_logger.info "старт"
    
    @day_date = "11/09/2001"
    @dailydigest_news = New.all #where(:digest=>:dayly)
    @dailydigest_users = User.where(:digest=>:dayly)
    @dailydigest_users.each do |dailydigest_user|
      NewsMailer.daily_digest(dailydigest_user,@dailydigest_news,@day_date).deliver_now
    
    # Do something later
    end
  end
  
end
