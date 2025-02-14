require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      username: "testuser",
      email: "test@example.com",
      password: "password123"
    )
    @category = Category.new(
      name: "Work",
      user: @user
    )
  end

  test "should save valid category" do
    assert_difference 'Category.count' do
      @category.save
    end
  end

  test "should not save category without name" do
    @category.name = nil
    assert_no_difference 'Category.count' do
      @category.save
    end
    assert_includes @category.errors[:name], "can't be blank"
  end

  test "should not save category without user" do
    @category.user = nil
    assert_no_difference 'Category.count' do
      @category.save
    end
    assert_includes @category.errors[:user], "must exist"
  end

  test "should enforce name uniqueness per user" do
    @category.save
    duplicate_category = Category.new(name: "Work", user: @user)
    
    assert_no_difference 'Category.count' do
      duplicate_category.save
    end
    assert_includes duplicate_category.errors[:name], "has already been taken"
  end

  test "should allow same name for different users" do
    @category.save
    other_user = User.create!(
      username: "otheruser",
      email: "other@example.com",
      password: "password123"
    )
    
    other_category = Category.new(name: "Work", user: other_user)
    assert_difference 'Category.count' do
      other_category.save
    end
  end

  test "should destroy dependent tasks when category is destroyed" do
    @category.save
    @category.tasks.create!(name: "Sample Task")
    
    assert_difference 'Task.count', -1 do
      @category.destroy
    end
  end
end