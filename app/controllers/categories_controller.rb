class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to dashboard_index_path, notice: "Category created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to dashboard_index_path, notice: "Category deleted successfully"
    else
      redirect_to dashboard_index_path, alert: "Failed to delete category. Please try again."
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
