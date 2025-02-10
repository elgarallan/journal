class CategoriesController < ApplicationController
    before_action :require_login
  
    def new
      @category = Category.new
    end
  
    def create
      @category = current_user.categories.build(category_params)
      if @category.save
        redirect_to dashboard_path, notice: "Category created successfully!"
      else
        render :new
      end
    end
  
    private
  
    def category_params
      params.require(:category).permit(:name)
    end
  
    def require_login
      redirect_to login_path unless current_user
    end
  end
  