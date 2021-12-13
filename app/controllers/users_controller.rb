class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:update_profile, :edit_profile]
  before_action :check_permissions, except: [:update_profile,:edit_profile]
  
  def check_permissions
  
    unless (user_signed_in? && current_user.admin?) then
      
      #render json: {error: "Вы не имеете прав для доступа к данному разделу " << (user_signed_in? ? "true" : "false")}
      #return false
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/forbid.html", :layout => false, :status => :ok }
      #  format.html { redirect_to root_path, notice: "Вы не имеете прав для доступа к разделу admin " << (user_signed_in? ? "true" : "false") }
      end
    end
    return true
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end
  
  # GET /users/1/edit
  def edit_profile
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  #PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_profile
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to @edit_profile_path, notice: 'Ваш профиль успешно сохранен.' }
        #format.json { render :show, status: :ok, location: @user }
      else
        #format.html { render :edit_profile }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def set_current_user
      unless (user_signed_in?) then
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/forbid.html", :layout => false, :status => :ok }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
        return false
      end
    @user = current_user
    return true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if(current_user.admin?)
        params.require(:user).permit(:email, :name, :admin, :editor, :digest)
      else
        params.require(:user).permit(:email, :name, :digest)
      end
    end
end
