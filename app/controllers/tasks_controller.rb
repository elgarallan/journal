class TasksController < ApplicationController
    before_action :set_category
  
    def new
      @task = @category.tasks.build
    end
  
    def create
      @task = @category.tasks.build(task_params)
      if @task.save
        redirect_to dashboard_path, notice: "Task added successfully!"
      else
        render :new
      end
    end

    def edit
      @category = Category.find(params[:category_id])
      @task = @category.tasks.find(params[:id])
    end

    def update
      @category = Category.find(params[:category_id])
      @task = @category.tasks.find(params[:id])
      
      if @task.update(task_params)
        redirect_to dashboard_path, notice: "Task updated successfully!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @category = Category.find(params[:category_id])
      @task = @category.tasks.find(params[:id])
    
      @task.destroy
      redirect_to dashboard_path, notice: "Task deleted successfully!"
    end
    

    private
  
    def set_category
      @category = Category.find(params[:category_id])
    end
  
    def task_params
      params.require(:task).permit(:name)
    end
  end
  