require "test_helper"

class SnapshotTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Example User", email: "ww@w.com", password: "password", password_confirmation: "password")
    @snapshot = @user.snapshots.build(content: "Lorem ipsum")
    @snapshot1 = @user.snapshots.build(content: "Lorem ipsum")
    @most_recent = @user.snapshots.build(content: "Lorem ipsum", created_at: 1.day.ago)
    @snapshots = [@most_recent, @snapshot1]
  end

  test "should be valid" do
    assert @snapshot.valid?
  end

  test "user id should be present" do
    @snapshot.user_id = nil
    assert_not @snapshot.valid?
  end

  test "content should be present" do
    @snapshot.content = "   "
    assert_not @snapshot.valid?
  end

  test "content should be at most 140 characters" do
    @snapshot.content = "a" * 141
    assert_not @snapshot.valid?
  end

end
