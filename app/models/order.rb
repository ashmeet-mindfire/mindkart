class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  def calculate_total
    self.total = order_items.sum("price")
  end
end
