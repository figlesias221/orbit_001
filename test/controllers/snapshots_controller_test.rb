require "test_helper"

class SnapshotsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(name: "Example User", email: "2@2.com", password: "password", password_confirmation: "password")
    @user2 = User.create(name: "Example User", email: "22@2.com", password: "password", password_confirmation: "password")
    @snapshot = @user.snapshots.create(content: "Lorem ipsum")
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Snapshot.count' do
      post snapshots_path, params: { snapshot: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Snapshot.count' do
      delete snapshot_path(@snapshot)
    end
    assert_redirected_to login_url
  end

  # test "should redirect destroy for wrong snapshot" do
  #   log_in_as(@user2)
  #   snapshot = snapshots(:ants)
  #   assert_no_difference 'Snapshot.count' do
  #     delete snapshot_path(snapshot)
  #   end
  #   assert_redirected_to root_url
  # end
end
