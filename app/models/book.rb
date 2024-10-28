class Book < ApplicationRecord
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true
  validates :genre, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :stock_quantity, presence: true
  validates :publisher, presence: true
  validates :published_date, presence: true
end
