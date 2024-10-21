class BookController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_path, notice: "Book created successfully"
    else
      render :new
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price, :description, :stock_quantity, :published_date, :publisher, :genre, :cover_image)
  end
end
