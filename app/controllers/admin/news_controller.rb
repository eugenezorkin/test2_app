class Admin::NewsController < ApplicationController
  before_action :set_news , only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!

  #before_action :check_permissions, :only => [:new, :create, :update, :cancel, :edit]
  before_action :set_current_user_id_to_created_news, only: :create
  before_action :set_current_user_id_to_editor, only: :update
 
  def check_permissions
  
    unless can_edit? then
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/forbid.html", :layout => false, :status => :ok }
      end
    end
    return true
  end
  
  
  
  def can_edit? 
    return (user_signed_in? && (current_user.admin? || current_user.editor?))
  end

  # GET /news
  # GET /news.json
  def index
    @news = News.all
    @can_edit = can_edit?;
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)

    respond_to do |format|
      if @news.save
        flash[:success] = t('.success')
        format.html { redirect_to action: 'edit', id: @news.id }
        format.json { render :edit, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        flash[:success] = t('.success')
        format.html { redirect_to action: 'edit', id: @news.id , status: :see_other}
        format.json { render :show, status: :see_other, location: @news }
      else
        format.html { render action: 'edit', id: @news.id, status: :see_other }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to action: 'index' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :content, :user_id) 
    end
  
    def set_current_user_id_to_created_news
      if params[:news][:user_id].nil?
        params[:news][:user_id] = current_user.id
        params[:news][:last_editor_id] = current_user.id
      else
        params[:news][:last_editor_id] = params[:news][:user_id]
      end
    end
    
    def set_current_user_id_to_editor
      if not current_user.nil?
        params[:news][:last_editor_id] = current_user.id
      else
        params[:news][:last_editor_id] = 0
      end
    end
end
