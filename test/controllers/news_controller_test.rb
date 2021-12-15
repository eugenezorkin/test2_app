require "test_helper"

class NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news = news(:one)
  end

  test "should get index" do
    get news_index_url
    assert_response :success
  end

  test "should show news" do
    get news_url(@news)
    assert_response :success
  end

end
