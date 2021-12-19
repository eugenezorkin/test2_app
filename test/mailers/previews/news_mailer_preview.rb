# Preview all emails at http://localhost:3000/rails/mailers/news_mailer
class NewsMailerPreview < ActionMailer::Preview

# Preview this email at
  # http://localhost:3000/rails/mailers/user_mailer/account_activation
  def dailydigest_email
    dailydigest_user = User.first
    dailydigest_news = News.all
    user = User.first
    NewsMailer.dailydigest_email(dailydigest_user,dailydigest_news).deliver_now
  end
  
  
  def weeklydigest_email
    weeklydigest_user = User.first
    weeklydigest_news = News.all
    user = User.first
    NewsMailer.weeklydigest_email(weeklydigest_user,weeklydigest_news).deliver_now
  end
  
  def test_email
    user = User.first
    NewsMailer.test_email(user).deliver_now
  end

end
