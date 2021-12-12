class NewsMailer < ApplicationMailer
  default from: 'news@3d17b7920b48403185e55844a2bae8b0.vfs.cloud9.us-east-2.amazonaws.com'
  
  
  def dailydigest_email(user,digest_news,day_date)
    #my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    #my_logger.info "отправка письма на адрес " << user.email
    #@user = params[:user]
    #@url  = 'http://example.com/login'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    #my_logger.info user.email
    
    #user = User.first;
    #digest_news = New.all
    #day_date = "11/09/2001"
    @user = user
    @news = digest_news
    @day_date = day_date
    mail to: "test@test.ru", subject: "Ежедневный дайджест"
    #my_logger.info "welcome user end"

    end
    
end
