class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :set_profile_user, only: [:update, :edit]

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

  # POST /users
  # POST /users.json
  def create
    user_params.user_id = current_user.id
    
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = t('.success')
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = t('.success')
        format.html { redirect_to profile_path}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:success] = t('.success')
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    def set_profile_user
      unless (user_signed_in?) then
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/forbid.html", :layout => false, :status => :ok }
        end
      end
      @user = current_user
      return true
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:name, :digest)
    end
end
