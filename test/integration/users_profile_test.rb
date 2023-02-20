require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = User.create(name: "Example User", email: "w@w.com", password: "password", password_confirmation: "password")
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    @user.snapshots.paginate(page: 1).each do |snapshot|
      assert_match snapshot.content, response.body
    end
  end
end
