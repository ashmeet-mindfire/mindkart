require "test_helper"

class BookControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get book_new_url
    assert_response :success
  end
end
