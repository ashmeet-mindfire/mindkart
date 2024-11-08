class UsersController < ApplicationController
  def change_admin_status
    begin
      @user = User.find(params[:id])

      if @user.update(update_user_params)
        redirect_to dashboard_index_path, notice: "User updated successfully"
      else
        redirect_to dashboard_index_path, alert: "Unable to update user"
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to dashboard_index_path, alert: "User not found."
    end
  end

  private
  def update_user_params
    params.require(:user).permit(:is_admin)
  end
end
