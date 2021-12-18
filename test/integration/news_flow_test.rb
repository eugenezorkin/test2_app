require "test_helper"
require "capybara/rails"


class NewsFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Capybara
  
  def create_user_and_autorize
    
    test_email = "testintegration@testintegration.ru"
    test_password = "test_integration_pwd"
    test_name = "test_integration_name"
    user = User.create(:password => test_password, :password_confirmation => test_password, :email => test_email, :name => test_name, :editor => true)
    assert user.save!, "error while creating test user"
    
    get new_user_session_path
    assert_response :success
    assert_select "h1", "Авторизация", "no h1 with autorization page title found"
    
    post user_session_path, params: {"user"=>{"email"=>test_email, "password"=>test_password}}
    follow_redirect!

    assert_equal root_path, path
    assert_select "div.alert", "Вы успешно вошли в систему."
    
  end
  
  test "can see the news item on the tindex page" do
    get root_path
    assert_response :success
    assert_select "a", "Новости", "no news menu item found"
  end
  
  
  test "can create edit and delete news" do
    create_user_and_autorize
    get admin_news_index_path
    assert_response :success
    assert_select "h1", "Новости"
    assert_select "a", "Создать новость"
  
    get new_admin_news_path
    assert_response :success
    assert_select "h1", "Новая новость"
    
    test_title = "test integration title"
    test_content = "test integration content"
    post url_for({controller: "admin/news",action: "create"}), params: {"news"=>{"title"=>test_title, "content"=>test_content}}
    assert_response :redirect
    follow_redirect!
    
    last_id = News.last.id
    assert_generates path, { controller: "admin/news", action: "edit", id: last_id }
    assert_select "div.alert", "Новость успешно создана."
    assert_select "input[name='news[title]'][value=?]", test_title
    assert_select "textarea[name='news[content]']", {:count=>1, :text=>test_content}
    
    new_test_title = "test integration title ver2"
    new_test_content = "test integration content ver2"
    patch url_for({controller: "admin/news",action: "show", id: last_id }), params: {"news"=>{"title"=>new_test_title, "content"=>new_test_content}}
    assert_response :redirect
    follow_redirect!
    
    assert_generates path, { controller: "admin/news", action: "edit", id: last_id }
    assert_select "div.alert", "Новость успешно изменена."
    assert_select "input[name='news[title]'][value=?]", new_test_title
    assert_select "textarea[name='news[content]']", {:count=>1, :text=>new_test_content}
    
    get admin_news_index_path
    assert_response :success
    assert_select "h1", "Новости"
    url_destroy = url_for({controller: "admin/news",action: "destroy", id: last_id, only_path: true })
    assert_select "a[href=?]", url_destroy
    
    
    delete url_for({controller: "admin/news",action: "destroy", id: last_id})
    assert_response :redirect
    follow_redirect!
    assert_equal path, admin_news_index_path
    assert_select "div.alert", "Новость была удалена."
    
    refute_equal last_id,News.last.id
    
  end
  
  
end
