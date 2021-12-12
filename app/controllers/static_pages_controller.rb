class StaticPagesController < ApplicationController

  
  def home
    
    @dailydigest_users = User.where(:digest=>:dayly)
    @dailydigest_users.each do |dailydigest_user|
      UserMailer.welcome_email(dailydigest_user).deliver_now
    end
    
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
