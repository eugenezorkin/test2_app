class NewsMailer < ApplicationMailer
  default from: 'news@3d17b7920b48403185e55844a2bae8b0.vfs.cloud9.us-east-2.amazonaws.com'
  
  
  def dailydigest_email(user,digest_news)
  
    @user = user
    @news = digest_news
    mail to: user.email, subject: "Ежедневный дайджест"
  end
    
    
    
  def weeklydigest_email(user,digest_news)
  
    @user = user
    @news = digest_news
    mail to: user.email, subject: "Еженедельный дайджест"
  end
  
  def test_email(user)
    
    mail to: user.email, subject: "Тсет"
  end
end
