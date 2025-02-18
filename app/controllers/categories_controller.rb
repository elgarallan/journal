class CategoriesController < ApplicationController
    before_action :require_login
    before_action :set_category, only: [:edit, :update, :destroy]
  
    def new
      @category = Category.new
    end
  
    def create
      @category = current_user.categories.build(category_params)
      if @category.save
        redirect_to dashboard_path, alert: "Category created successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end
  
    def update
      if @category.update(category_params)
        redirect_to dashboard_path, notice: "Category updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category.destroy
      redirect_to dashboard_path, notice: "Category deleted successfully!"
    end
  
    private

    def set_category
      @category = current_user.categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to dashboard_path, alert: "Category not found."
    end
  
    def category_params
      params.require(:category).permit(:name)
    end
  
    def require_login
      redirect_to login_path unless current_user
    end
  end
  