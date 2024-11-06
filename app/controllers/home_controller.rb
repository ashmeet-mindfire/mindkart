class HomeController < ApplicationController
  def index
    @books = Book.limit(5)
  end
end
