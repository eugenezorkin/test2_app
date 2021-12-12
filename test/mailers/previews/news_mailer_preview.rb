# Preview all emails at http://localhost:3000/rails/mailers/news_mailer
class NewsMailerPreview < ActionMailer::Preview

# Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def dailydigest_email
    my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    my_logger.info "старт"
    
    @day_date = "11/09/2001"
    @dailydigest_news = News.all #where(:digest=>:dayly)
    @dailydigest_users = User.where(:digest=>:dayly)
    NewsMailer.dailydigest_email(@dailydigest_users.first,@dailydigest_news,@day_date).deliver_now
    #@dailydigest_users.each do |dailydigest_user|
      #NewsMailer.dailydigest_email(dailydigest_user,@dailydigest_news,@day_date).deliver_now
    #end
    # Do something later
  end

end
