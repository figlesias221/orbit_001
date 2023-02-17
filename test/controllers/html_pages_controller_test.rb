require "test_helper"

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Orbit001 | Home"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Orbit001 | Help"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "Orbit001 | About"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Orbit001 | Contact"
  end
end
