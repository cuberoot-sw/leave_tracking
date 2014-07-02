class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def destroy

  end

  def profile_edit
    @user = User.find(params[:id])
  end

  def profile_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path(@user), notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_profile_pic
    @user = User.find(params[:id])
    @user.remove_profile_pic!
    @user.save
    render :json => {:status  => "success"}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!
    end

end
