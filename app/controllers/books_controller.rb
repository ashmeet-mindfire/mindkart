class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :admin_only, only: %i[ edit update destroy ]
  def index
    @books = Book.page(params[:page]).per(10)
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def show
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
    @categories = Category.all
  end

  def update
    if @book.update(book_params)
      redirect_to dashboard_index_path, notice: "Book was successfully updated."
    else
      @categories = Category.all
      Rails.logger.error("Failed to update book: #{@book.errors.full_messages.join(", ")}")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @book.destroy
      redirect_to dashboard_index_path, notice: "Book deleted successfully."
    else
      Rails.logger.error("Failed to delete book with ID: #{@book.id}")
      redirect_to dashboard_index_path, alert: "Failed to delete the book."
    end
  end

  def restore
    begin
      @book = Book.only_deleted.find(params[:id])
      if @book.restore
        redirect_to dashboard_index_path, notice: "Book was successfully restored."
      else
        redirect_to dashboard_index_path, alert: "Failed to restore the book."
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to books_path, alert: "Book not found."
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price, :description, :stock_quantity, :published_date, :publisher, :category_id, :image)
  end

  def set_book
    begin
      @book = Book.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to books_path, alert: "Book not found."
    end
  end
end
