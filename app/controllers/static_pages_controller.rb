class StaticPagesController < ApplicationController

  
  def home
    
    @day_date = "11/09/2001"
    @start_date = (Date.today - 1.week).beginning_of_week.beginning_of_day
    @end_date   = (Date.today - 1.week).end_of_week.end_of_day
    #@dailydigest_news = New.all 
    #@dailydigest_news = News.where("created_at > ? AND created_at < ?", Date.today.at_beginning_of_month - 2.months, Date.today).group("date_trunc('month', created_at)").count
    #Date.today.at_beginning_of_month - 2.months, Date.today
    @dailydigest_news = News.where("created_at > ? AND created_at < ?", @start_date, @end_date);
    
    
    @start_date = (Date.today - 1.day).beginning_of_day
    @end_date   = (Date.today - 1.day).end_of_day
    @dailydigest_news = News.where("created_at > ? AND created_at < ?", @start_date, @end_date);
    @dailydigest_users = User.where(:digest=>:dayly)
    
    if @dailydigest_news.count > 0 && @dailydigest_users.count >0
      @dailydigest_users.each do |dailydigest_user|
        #NewsMailer.daily_digest(dailydigest_user,@dailydigest_news,@day_date).deliver_now
      end
    end
    
    
    @dailydigest_users = User.where(:digest=>:dayly)
    #@dailydigest_users.each do |dailydigest_user|
    #  NewsMailer.daily_digest(dailydigest_user,@dailydigest_news,@day_date).deliver_now
    #end
    #abort("Message goes here")
    @user = User.first;
    my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    my_logger.info "user "+@user.name
    #respond_to do |format|
      if @user.save
        my_logger.info "user save"
        # Сказать UserMailer отослать приветственное письмо после сохранения
        #UserMailer.welcome_email(@user).deliver_now
        #UserMailer.with(user: @user).welcome_email.deliver_now #.deliver_later
        my_logger.info "after UserMailer with"
        #format.html { redirect_to(@user, notice: 'Пользователь успешно создан.') }
        #format.json { render json: @user, status: :created, location: @user }
      else
        #format.html { render action: 'new' }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
    
    
    @firsttitle = "no value";
    @isAdmin = "no_value";
    @isEditor = "no_value";
    if user_signed_in?
      @firsttitle = User.first.news.first.title;
      @curusername = current_user.email
      @isId1 = current_user.role?;
      @isAdmin = current_user.admin?;
      @isEditor = current_user.editor?;
    else 
      @curusername = "no logged user";
      @isId1 = "no id";
    end;
    
    @islogged = user_signed_in?;
    
    @news = News.find("3")

    @iscan = can? :update, @news # => true
    
  end
end
