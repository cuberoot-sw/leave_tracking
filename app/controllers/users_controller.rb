class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page]).all
  end

  def destroy

  end
end
