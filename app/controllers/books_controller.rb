class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def show
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to books_path, alert: "Book not found."
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to dashboard_index_path, notice: "Book created successfully"
    else
      @categories = Category.all
      Rails.logger.error("Failed to create book: #{@book.errors.full_messages.join(", ")}")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    begin
      @book = Book.find(params[:id])
      @categories = Category.all
    rescue ActiveRecord::RecordNotFound
      redirect_to dashboard_index_path, alert: "Book not found."
    end
  end

  def update
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to dashboard_index_path, alert: "Book not found."
      return
    end

    if @book.update(book_params)
      redirect_to dashboard_index_path, notice: "Book was successfully updated."
    else
      @categories = Category.all
      Rails.logger.error("Failed to update book: #{@book.errors.full_messages.join(", ")}")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book.nil?
      redirect_to dashboard_index_path, alert: "Book not found."
      return
    end

    if @book.destroy
      redirect_to dashboard_index_path, notice: "Book deleted successfully."
    else
      Rails.logger.error("Failed to delete book with ID: #{@book.id}")
      redirect_to dashboard_index_path, alert: "Failed to delete the book."
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price, :description, :stock_quantity, :published_date, :publisher, :category_id, :image)
  end
end
