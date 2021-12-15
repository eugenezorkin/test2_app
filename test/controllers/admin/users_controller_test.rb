require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get url_for({controller: 'admin/users', action: :index})
    assert_response :success
  end


  test "should show user" do
    get url_for({controller: 'admin/users', action: :show, id: @user.id})
    assert_response :success
  end

  test "should get edit" do
    get url_for({controller: 'admin/users', action: :edit, id: @user.id})
    assert_response :success
  end

  test "should update user" do
    my_logger ||= Logger.new("#{Rails.root}/log/my.log")
    my_logger.info "USER ONTROLLER TEST irl" 
      my_logger.info url_for({controller: 'admin/users', action: :show, id: @user.id})
    patch url_for({controller: 'admin/users', action: :show, id: @user.id}), params: { user: { email: "newtest@test.com", name: "new test name" } }
    assert_redirected_to url_for({controller: 'admin/users', action: :edit, id: @user.id})
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete url_for({controller: 'admin/users', action: :show, id: @user.id})
    end

    assert_redirected_to url_for({controller: 'admin/users', action: :index})
  end
end
