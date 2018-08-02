class TasksController < ApplicationController
  before_action :correct_user, only: [:destroy, :update, :show]
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @user = current_user
      @tasks = current_user.tasks.order('created_at DESC')
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @user = current_user
    @task = current_user.tasks.build # form_for用
    @tasks = current_user.tasks.order('created_at DESC')
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に書き込みされました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが正常に書き込まれませんでした'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に書き込みされました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが正常に書き込まれませんでした'
      render :edit
    end
    
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = '予定は正常に削除されました'
    redirect_to tasks_url
  end

  private
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end
