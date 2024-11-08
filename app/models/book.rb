class Book < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_paranoid

  has_many :cart_items
  has_many :carts, through: :cart_items
  has_one_attached :image
  belongs_to :category

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true
  validates :category_id, presence: true
  validates :price, presence: true
  validates :description, presence: true
  validates :stock_quantity, presence: true
  validates :publisher, presence: true
  validates :published_date, presence: true
end
