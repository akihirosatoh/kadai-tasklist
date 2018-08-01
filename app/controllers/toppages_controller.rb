class ToppagesController < ApplicationController
  def index
    if logged_in?
    @user = current_user
    @task_manager = current_user.task_managers.build
    @task_managers = current_user.task_managers.order('created_at DESC').page(params[:page])
    end
    
  end
end
