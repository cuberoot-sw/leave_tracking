class HolidaysController < ApplicationController
  before_action :set_holiday, only: [:show, :edit, :update, :destroy]
  before_filter :check_is_admin?, :except => [:filter_holidays]

  # GET /holidays
  # GET /holidays.json
  def index
    @setting = Setting.find(params[:setting_id])
    @holidays = @setting.holidays.order('date ASC').paginate(:page => params[:page])
  end

  # GET /holidays/1
  # GET /holidays/1.json
  def show
  end

  # GET /holidays/new
  def new
    @setting = Setting.find(params[:setting_id])
    @holiday = @setting.holidays.new
  end

  # GET /holidays/1/edit
  def edit
  end

  # POST /holidays
  # POST /holidays.json
  def create
    @setting = Setting.find(params[:setting_id])
    @holiday = @setting.holidays.new(holiday_params)
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to [@setting, @holiday], notice: 'Holiday was successfully created.' }
        format.json { render :show, status: :created, location: @holiday }
      else
        format.html { render :new }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holidays/1
  # PATCH/PUT /holidays/1.json
  def update
    respond_to do |format|
      if @holiday.update(holiday_params)
        format.html { redirect_to [@setting, @holiday], notice: 'Holiday was successfully updated.' }
        format.json { render :show, status: :ok, location: @holiday }
      else
        format.html { render :edit }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.json
  def destroy
    @holiday.destroy
    respond_to do |format|
      format.html { redirect_to setting_holidays_url }
      format.json { head :no_content }
    end
  end

  def filter_holidays
    @year = params[:year] ? params[:year] : Time.now.year
    @setting = Setting.where(year: @year).first
    @holidays = @setting.holidays.order('date ASC').paginate(:page => params[:page])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_holiday
      @setting = Setting.find(params[:setting_id])
      @holiday = Holiday.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def holiday_params
      params.require(:holiday).permit(:date, :occasion)
    end

    def check_is_admin?
      current_user.is_admin?
    end
end
