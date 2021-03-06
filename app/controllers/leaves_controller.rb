class LeavesController < ApplicationController
  before_action :set_leave, only: [:show, :edit, :update, :destroy]

  # GET /leaves
  # GET /leaves.json
  def index
    status = params[:status] ? params[:status] : 'pending'
    @leaves = current_user.leaves.where(status: status).paginate(:page => params[:page])
  end

  # GET /leaves/1
  # GET /leaves/1.json
  def show
  end

  # GET /leaves/new
  def new
    @user = User.find(params[:user_id])
    @leave = @user.leaves.new
  end

  # GET /leaves/1/edit
  def edit
  end

  # POST /leaves
  # POST /leaves.json
  def create
    @user = User.find(params[:user_id])
    @leave = @user.leaves.new(leave_params)

    respond_to do |format|
      if @leave.save
        @leave.notify_email(current_user)
        format.html { redirect_to user_leafe_path(@user, @leave), notice: 'Leave was successfully created.' }
        format.json { render :show, status: :created, location: @leave }
      else
        format.html { render :new }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaves/1
  # PATCH/PUT /leaves/1.json
  def update
    respond_to do |format|
      if @leave.update(leave_params)
        @leave.notify_updated_email(current_user)
        format.html { redirect_to user_leafe_path(@user, @leave), notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaves/1
  # DELETE /leaves/1.json
  def destroy
    @leave.destroy
    respond_to do |format|
      format.html { redirect_to leaves_url, notice: 'Leave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel
    @leave = Leave.find(params[:id])
    @leave.cancel!
    if @leave.save
      @leave.notify_email(current_user)
      redirect_to leaves_url, notice: 'Leave was successfully Cancelled.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @user = User.find(params[:user_id])
      @leave = Leave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_params
      params.require(:leave).permit!
      #params.require(:leave).permit(:start_date, :end_date, :no_of_days, :status, :reason, :approved_on, :approved_by, :rejection_reason, :references)
    end

end
