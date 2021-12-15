require "test_helper"

class Admin::NewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @news = news(:one)
  end

  test "should get index" do
    get url_for({controller: 'admin/news', action: :index })
    assert_response :success
  end

  test "should get new" do
    get url_for({controller: 'admin/news', action: :new })
    assert_response :success
  end

  test "should create news" do
    assert_difference('News.count') do
      user = User.first
      post url_for({controller: 'admin/news', action: :index}), params: { news: { author: @news.author, content: @news.content, title: @news.title, user_id: user.id, last_editor_id: 1, number_edits: 1, edits_number: 1 } }
    end

    #assert_redirected_to news_url(News.last)
    assert_redirected_to url_for({controller: 'admin/news', action: :edit, id: News.last.id })
  end

  test "should show news" do
    get url_for({controller: 'admin/news', action: :show, id: @news.id })
    assert_response :success
  end

  test "should get edit" do
    get url_for({controller: 'admin/news', action: :edit, id: @news.id })
    assert_response :success
  end

  test "should update news" do
    user = User.first
    patch url_for({controller: 'admin/news', action: :show, id: @news.id }), params: { news: { author: 1, content: "new test content", title: "new test title",user_id: user.id } }
    assert_redirected_to url_for({controller: 'admin/news', action: :edit, id: @news.id })
  end

  test "should destroy news" do
    assert_difference('News.count', -1) do
      delete url_for({controller: 'admin/news', action: :show, id: @news.id })
    end

    assert_redirected_to url_for({controller: 'admin/news', action: :index })
  end
end
