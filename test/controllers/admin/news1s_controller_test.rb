require "test_helper"

class Admin::News1sControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_news1 = admin_news1s(:one)
  end

  test "should get index" do
    get admin_news1s_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_news1_url
    assert_response :success
  end

  test "should create admin_news1" do
    assert_difference('Admin::News1.count') do
      post admin_news1s_url, params: { admin_news1: {  } }
    end

    assert_redirected_to admin_news1_url(Admin::News1.last)
  end

  test "should show admin_news1" do
    get admin_news1_url(@admin_news1)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_news1_url(@admin_news1)
    assert_response :success
  end

  test "should update admin_news1" do
    patch admin_news1_url(@admin_news1), params: { admin_news1: {  } }
    assert_redirected_to admin_news1_url(@admin_news1)
  end

  test "should destroy admin_news1" do
    assert_difference('Admin::News1.count', -1) do
      delete admin_news1_url(@admin_news1)
    end

    assert_redirected_to admin_news1s_url
  end
end
