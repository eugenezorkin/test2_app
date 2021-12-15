# Preview all emails at http://localhost:3000/rails/mailers/news_mailer
class NewsMailerPreview < ActionMailer::Preview

# Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def dailydigest_email
    @start_date = (Date.today - 1.week).beginning_of_week.beginning_of_day
    @end_date   = (Date.today - 1.week).end_of_week.end_of_day
    @dailydigest_news = News.where("created_at > ? AND created_at < ?", @start_date, @end_date);
    @dailydigest_users = User.where(:digest=>:dayly)
    
    if @dailydigest_news.count > 0 && @dailydigest_users.count >0
      @dailydigest_users.each do |dailydigest_user|
        NewsMailer.dailydigest_email(dailydigest_user,@dailydigest_news,@day_date).deliver_now
      end
    end
  end
  
  
  def weeklydigest_email
    #@start_date = (Date.today - 1.week).beginning_of_week.beginning_of_day
    #@end_date   = (Date.today - 1.week).end_of_week.end_of_day
    
    #weeklydigest_news = News.where("created_at > ? AND created_at < ?", @start_date, @end_date);
    #weeklydigest_users = User.where(:digest=>:weekly)
    
    #if (weeklydigest_news.count>0 && weeklydigest_users.count>0)
    #  weeklydigest_users.each do |weeklydigest_user|
        weeklydigest_user = User.first
        weeklydigest_news = News.all
         user = User.first
    #NewsMailer.test_email(user).deliver_now
        NewsMailer.weeklydigest_email(weeklydigest_user,weeklydigest_news).deliver_now
    #  end
    #end
    #user = User.first
    #NewsMailer.test_email(user).deliver_now
  end
  
  def test_email
    user = User.first
    NewsMailer.test_email(user).deliver_now
  end

end
