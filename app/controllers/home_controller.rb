class HomeController < ApplicationController
    before_action :authenticate_user, only: :dashboard
  
    def welcome 
    end
  
    def dashboard
      @categories = current_user.categories
    end
  
  end