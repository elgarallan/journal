require "test_helper"

class TaskTest < ActiveSupport::TestCase
  def setup
    @category = Category.create(name: "Work") # Create a category for association
    @task = Task.new(name: "Finish report", category: @category) # Valid task
  end

  test "should be valid with a name and category" do
    assert @task.valid?
  end

  test "should be invalid without a name" do
    @task.name = nil
    assert_not @task.valid?, "Task is valid without a name"
  end

  test "should belong to a category" do
    assert_equal @category, @task.category
  end
end
