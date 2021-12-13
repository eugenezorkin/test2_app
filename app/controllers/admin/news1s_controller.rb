class Admin::News1sController < ApplicationController
  before_action :set_admin_news1, only: [:show, :edit, :update, :destroy]

  # GET /admin/news1s
  # GET /admin/news1s.json
  def index
    @admin_news1s = Admin::News1.all
  end

  # GET /admin/news1s/1
  # GET /admin/news1s/1.json
  def show
  end

  # GET /admin/news1s/new
  def new
    @admin_news1 = Admin::News1.new
  end

  # GET /admin/news1s/1/edit
  def edit
  end

  # POST /admin/news1s
  # POST /admin/news1s.json
  def create
    @admin_news1 = Admin::News1.new(admin_news1_params)

    respond_to do |format|
      if @admin_news1.save
        format.html { redirect_to @admin_news1, notice: 'News1 was successfully created.' }
        format.json { render :show, status: :created, location: @admin_news1 }
      else
        format.html { render :new }
        format.json { render json: @admin_news1.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/news1s/1
  # PATCH/PUT /admin/news1s/1.json
  def update
    respond_to do |format|
      if @admin_news1.update(admin_news1_params)
        format.html { redirect_to @admin_news1, notice: 'News1 was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_news1 }
      else
        format.html { render :edit }
        format.json { render json: @admin_news1.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/news1s/1
  # DELETE /admin/news1s/1.json
  def destroy
    @admin_news1.destroy
    respond_to do |format|
      format.html { redirect_to admin_news1s_url, notice: 'News1 was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_news1
      @admin_news1 = Admin::News1.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_news1_params
      params.fetch(:admin_news1, {})
    end
end
