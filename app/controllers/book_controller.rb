class BookController < ApplicationController
  def index
    @books = Book.all
  end
  def new
    @book = Book.new
  end

  def details
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_path, notice: "Book created successfully"
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_path, notice: "Book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    puts "Ashmeet #{params}"
    @book = Book.find(params[:id])
    puts @book.title
    @book.destroy
    redirect_to admin_path, notice: "Book deleted successfully"
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :isbn, :price, :description, :stock_quantity, :published_date, :publisher, :genre, :cover_image)
  end
end
