class CartItemsController < ApplicationController
  def index
    @cart = current_user.cart || Cart.create(user: current_user)
    @order = Order.new
  end
  def create
    @cart = current_user.cart || Cart.create(user: current_user)
    book = Book.find(params[:book_id])

    cart_item = @cart.cart_items.find_by(book_id: book.id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      @cart.cart_items.create(book: book, quantity: 1)
    end

    redirect_to books_path, notice: "Book added to cart."
  end

  def destroy
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to cart_path
  end
end