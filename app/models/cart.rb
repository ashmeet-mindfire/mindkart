class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :books, through: :cart_items

  # Add a method to calculate the total price of the cart
  def total_price
    cart_items.includes(:book).sum("cart_items.quantity * books.price")
  end
end
