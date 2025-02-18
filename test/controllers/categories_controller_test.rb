require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "testuser", email: "test@example.com", password: "password")
    @category = @user.categories.create!(name: "Work")
  end

  test "should get new if logged in" do
    log_in_as(@user)
    get new_category_path
    assert_response :success
  end

  test "should redirect new if not logged in" do
    get new_category_path
    assert_redirected_to login_path
  end

  test "should create category" do
    log_in_as(@user)
    assert_difference "@user.categories.count", 1 do
      post categories_path, params: { category: { name: "Personal" } }
    end
    assert_redirected_to dashboard_path
  end

  test "should not create category with invalid data" do
    log_in_as(@user)
    assert_no_difference "@user.categories.count" do
      post categories_path, params: { category: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit if logged in" do
    log_in_as(@user)
    get edit_category_path(@category)
    assert_response :success
  end

  test "should update category" do
    log_in_as(@user)
    patch category_path(@category), params: { category: { name: "Updated Name" } }
    assert_redirected_to dashboard_path
    assert_equal "Updated Name", @category.reload.name
  end

  test "should not update category with invalid data" do
    log_in_as(@user)
    patch category_path(@category), params: { category: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should delete category" do
    log_in_as(@user)
    assert_difference "@user.categories.count", -1 do
      delete category_path(@category)
    end
    assert_redirected_to dashboard_path
  end

  test "should redirect edit if not logged in" do
    get edit_category_path(@category)
    assert_redirected_to login_path
  end

  test "should redirect update if not logged in" do
    patch category_path(@category), params: { category: { name: "New Name" } }
    assert_redirected_to login_path
  end

  test "should redirect destroy if not logged in" do
    assert_no_difference "@user.categories.count" do
      delete category_path(@category)
    end
    assert_redirected_to login_path
  end

  test "should not allow another user to edit category" do
    other_user = User.create!(username: "otheruser", email: "other@example.com", password: "password")
    log_in_as(other_user)
    get edit_category_path(@category)
    assert_redirected_to dashboard_path
  end

  private

  def log_in_as(user)
    post login_path, params: { username: user.username, password: "password" }
  end
end
