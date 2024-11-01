class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  def index
    @books = Book.all
    @orders = Order.all.order(id: :asc)
    @categories = Category.all
    @users = User.all
  end

  private
  def admin_only
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
