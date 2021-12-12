class UserMailer < ApplicationMailer
  default from: 'notifications@3d17b7920b48403185e55844a2bae8b0.vfs.cloud9.us-east-2.amazonaws.com'
  
  
  def welcome_email(user)
    my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    my_logger.info "отправка письма на адрес " << user.email
    #@user = params[:user]
    #@url  = 'http://example.com/login'
    #mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    my_logger.info user.email
    @user = user
    @url  =  "/login"
    mail to: user.email, subject: "Account activation"
    #my_logger.info "welcome user end"
  end
end
