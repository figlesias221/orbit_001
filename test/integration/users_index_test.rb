require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = User.create(name: "Example User", email: "w@w2.com", password: "password", password_confirmation: "password", admin: true)
    @user = User.create(name: "Example User", email: "w@w.com", password: "password", password_confirmation: "password")
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index as non-admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

end
