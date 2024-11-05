class CartItemsController < ApplicationController
  def index
    @cart = current_user.cart || Cart.create(user: current_user)
    @order = Order.new
  end

  def create
    begin
      @cart = current_user.cart || Cart.create!(user: current_user)
      book = Book.find(params[:id])
      unless book
        redirect_to books_path, alert: "Book not found."
        return
      end

      cart_item = @cart.cart_items.find_by(book_id: book.id)

      if cart_item
        cart_item.quantity += 1
        unless cart_item.save
          redirect_to books_path, alert: "Failed to update cart item." and return
        end
      else
        new_cart_item = @cart.cart_items.create(book: book, quantity: 1)
        unless new_cart_item.persisted?
          redirect_to books_path, alert: "Failed to add book to cart." and return
        end
      end
      redirect_to books_path, notice: "Book added to cart."

    rescue StandardError => e
      redirect_to books_path, alert: "An error occurred: #{e.message}"
    end
  end

  def destroy
    begin
      @cart = current_user.cart
      cart_item = @cart.cart_items.find(params[:id])
      if cart_item.nil?
        redirect_to cart_items_path, alert: "Cart item not found."
        return
      end

      if cart_item.destroy
        redirect_to cart_items_path, notice: "Cart item removed successfully."
      else
        redirect_to cart_items_path, alert: "Failed to remove cart item."
      end

    rescue StandardError => e
      redirect_to cart_items_path, alert: "An error occurred: #{e.message}"
    end
  end
end
