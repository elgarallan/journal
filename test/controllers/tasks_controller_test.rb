require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(username: "testuser", email: "test@example.com", password: "password")
    @category = @user.categories.create!(name: "Work")
    @task = @category.tasks.create!(name: "Complete project")
  end

  test "should get new task form" do
    log_in_as(@user)
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should redirect new task form if not logged in" do
    get new_category_task_path(@category)
    assert_redirected_to login_path
  end

  test "should create task" do
    log_in_as(@user)
    assert_difference "@category.tasks.count", 1 do
      post category_tasks_path(@category), params: { task: { name: "New Task" } }
    end
    assert_redirected_to dashboard_path
  end

  test "should not create task with invalid data" do
    log_in_as(@user)
    assert_no_difference "@category.tasks.count" do
      post category_tasks_path(@category), params: { task: { name: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit task form" do
    log_in_as(@user)
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should update task" do
    log_in_as(@user)
    patch category_task_path(@category, @task), params: { task: { name: "Updated Task" } }
    assert_redirected_to dashboard_path
    assert_equal "Updated Task", @task.reload.name
  end

  test "should not update task with invalid data" do
    log_in_as(@user)
    patch category_task_path(@category, @task), params: { task: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should delete task" do
    log_in_as(@user)
    assert_difference "@category.tasks.count", -1 do
      delete category_task_path(@category, @task)
    end
    assert_redirected_to dashboard_path
  end

  test "should redirect edit if not logged in" do
    get edit_category_task_path(@category, @task)
    assert_redirected_to login_path
  end

  test "should redirect update if not logged in" do
    patch category_task_path(@category, @task), params: { task: { name: "New Name" } }
    assert_redirected_to login_path
  end

  test "should redirect destroy if not logged in" do
    assert_no_difference "@category.tasks.count" do
      delete category_task_path(@category, @task)
    end
    assert_redirected_to login_path
  end

  private

  def log_in_as(user)
    post login_path, params: { username: user.username, password: "password" }
  end
end
