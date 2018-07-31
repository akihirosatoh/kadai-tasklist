class TaskManagersController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @task_manager = current_user.task_managers.build(task_manager_params)
    if @task_manager.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @task_managers = current_user.task_managers.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました'
      render 'toppages/index'
    end
  end
  

  def destroy
    @task_manager.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def task_manager_params
  params.require(:task_manager).permit(:content)
  end
  
  def correct_user
  @task_manager = current_user.task_managers.find_by(id: params[:id])
    unless @task_manager
      redirect_to root_url
    end
  end
  
  
end
  
  
