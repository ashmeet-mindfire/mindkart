class CartController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = current_user.cart || Cart.create(user: current_user)
  end

  def add_item
    @cart = current_user.cart || Cart.create(user: current_user)
    book = Book.find(params[:book_id])

    # Check if the item already exists in the cart
    cart_item = @cart.cart_items.find_by(book_id: book.id)

    if cart_item
      # Increase the quantity if the item already exists
      cart_item.quantity += 1
      cart_item.save
    else
      # Create a new cart item if it doesn't exist
      @cart.cart_items.create(book: book, quantity: 1)
    end

    redirect_to book_list_path, notice: "Book added to cart."
  end

  def remove_item
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to cart_path
  end

  def update_item
    @cart = current_user.cart
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(quantity: params[:quantity])

    redirect_to cart_path
  end
end
