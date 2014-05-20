class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page]).all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

  end
end
