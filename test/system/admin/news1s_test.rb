require "application_system_test_case"

class Admin::News1sTest < ApplicationSystemTestCase
  setup do
    @admin_news1 = admin_news1s(:one)
  end

  test "visiting the index" do
    visit admin_news1s_url
    assert_selector "h1", text: "Admin/News1s"
  end

  test "creating a News1" do
    visit admin_news1s_url
    click_on "New Admin/News1"

    click_on "Create News1"

    assert_text "News1 was successfully created"
    click_on "Back"
  end

  test "updating a News1" do
    visit admin_news1s_url
    click_on "Edit", match: :first

    click_on "Update News1"

    assert_text "News1 was successfully updated"
    click_on "Back"
  end

  test "destroying a News1" do
    visit admin_news1s_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "News1 was successfully destroyed"
  end
end
