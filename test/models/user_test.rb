require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save valid user" do
    user = User.new(
      username: "testuser",
      email: "test@example.com",
      password: "password123"
    )
    assert_difference 'User.count' do
      user.save
    end
  end

  test "should not save user without required fields" do
    user = User.new
    assert_no_difference 'User.count' do
      user.save
    end
  end
end