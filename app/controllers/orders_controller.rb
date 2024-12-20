class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.page(params[:page]).per(5)
  end

  def show
    begin
      @order = current_user.orders.find(params[:id])
      @order_items = @order.order_items

      missing_books = @order_items.select { |item| item.book.nil? }

      if missing_books.any?
        Rails.logger.warn("Order contains items with deleted books: #{missing_books.map(&:id).join(', ')}")
        @order_items = @order_items.reject { |item| item.book.nil? }
        flash.now[:alert] = "Some books in this order have been deleted and will not be displayed."
      end

    rescue ActiveRecord::RecordNotFound
      redirect_to orders_path, alert: "Order not found."

    rescue StandardError => e
      Rails.logger.error("Error displaying order: #{e.message}")
      redirect_to orders_path, alert: "An error occurred while trying to display the order. Please try again."
    end
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = "pending"

    if items_in_stock?
      begin
        ActiveRecord::Base.transaction do
          if @order.save
            create_order_items
            @order.calculate_total
            @order.save!
            reduce_stock_quantity
            current_user.cart.destroy
            redirect_to orders_path, notice: "Order placed successfully!"
          else
            raise ActiveRecord::RecordInvalid.new(@order)
          end
        end
      rescue ActiveRecord::RecordInvalid
        redirect_to cart_path, alert: "Failed to place order. Please review your order and try again."
      rescue StandardError => e
        Rails.logger.error("Error placing order: #{e.message}")
        redirect_to cart_path, alert: "An unexpected error occurred. Please try again later."
      end
    else
      redirect_to cart_path, alert: "Insufficient stock for one or more items in your cart."
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id)
  end

  def update_order_params
    params.require(:order).permit(:status)
  end

  def create_order_items
    cart_items = current_user.cart.cart_items
    cart_items.each do |item|
      @order.order_items.create(
        book_id: item.book.id,
        quantity: item.quantity,
        price: item.book.price * item.quantity
      )
    end
  end

  def items_in_stock?
    current_user.cart.cart_items.all? do |item|
      item.book.stock_quantity >= item.quantity
    end
  end

  def reduce_stock_quantity
    current_user.cart.cart_items.each do |item|
      book = item.book
      book.stock_quantity -= item.quantity
      book.save
    end
  end
end
