class ShopController < ApplicationController
  def index
    @books = Book.all
  end
end
