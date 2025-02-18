require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  test "valid user signup" do
    get signup_path
    assert_response :success

    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "newuser", email: "new@example.com", password: "password123" } }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end

  test "invalid user signup (missing fields)" do
    get signup_path
    assert_response :success

    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "", email: "", password: "" } }
    end

    assert_redirected_to signup_path
  end
end
