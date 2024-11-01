class BookController < ApplicationController
  def index
    @books = Book.all
  end
  def new
    @book = Book.new
    @categories = Category.all
  end

  def details
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_path, notice: "Book created successfully"
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @book = Book.find(params[:id])
    @categories = Category.all
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_path, notice: "Book was successfully updated."
    else
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_path, notice: "Book deleted successfully"
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price, :description, :stock_quantity, :published_date, :publisher, :category_id, :image)
  end
end
