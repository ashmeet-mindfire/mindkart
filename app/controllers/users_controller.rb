class UsersController < ApplicationController
  def make_admin
    @user = User.find(params[:id])

    puts update_user_params
    if @user.update(update_user_params)
      redirect_to dashboard_index_path, notice: "User updated successfully"
    end
  end

  private
  def update_user_params
    params.require(:user).permit(:admin)
  end
end
