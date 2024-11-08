class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  def index
    @books = Book.page(params[:page]).per(5)
    @orders = Order.page(params[:page]).per(5)
    @categories = Category.page(params[:page]).per(5)
    @users = User.where.not(id: current_user.id).page(params[:page]).per(5)
    @deleted_books = Book.only_deleted.page(params[:page]).per(5)
  end
end
