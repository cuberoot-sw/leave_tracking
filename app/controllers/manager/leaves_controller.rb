class Manager::LeavesController < ApplicationController
  before_filter :check_is_manager?
  before_action :set_leave, only: [:show, :edit, :update, :destroy]

  # GET /leaves
  # GET /leaves.json
  def index
    if current_user.is_admin?
      status = params[:status] ? params[:status] : 'pending'
      @leaves = Leave.where(status: status).paginate(:page => params[:page])
    elsif current_user.is_manager?
      status = params[:status] ? params[:status] : 'pending'
      @leaves = Leave.joins(:user)
                  .where('users.manager_id = ?
                          AND leaves.status = ?',
                          current_user.id, status).paginate(:page => params[:page])
    end
  end

  # GET /leaves/1
  # GET /leaves/1.json
  def show
  end

  def approve
    @leave = Leave.find(params[:id])
    if @leave.approve!
      @leave.update_leave(current_user)
      @leave.notify_email(current_user)
      redirect_to manager_leaves_url, notice: 'Leave was successfully Approved.'
    end
  end

  def reject
    @leave = Leave.find(params[:id])
    @leave.add_reason(params[:reason])
    @leave.reject!
    if @leave.save
      @leave.notify_email(current_user)
      redirect_to manager_leaves_url, notice: 'Leave was successfully Rejected.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @leave = Leave.find(params[:id])
    end

    def check_is_manager?
      # manager and admin has facility to approve/reject leaves
      current_user.is_admin? || current_user.is_manager?
    end
end
