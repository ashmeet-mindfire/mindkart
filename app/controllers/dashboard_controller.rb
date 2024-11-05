class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  def index
    @books = Book.page(params[:page]).per(5)
    @orders = Order.page(params[:page]).per(5)
    @categories = Category.page(params[:page]).per(5)
    @users = User.where.not(id: current_user.id).page(params[:page]).per(5)
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
