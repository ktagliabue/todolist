class TasksController < ApplicationController
  
  before_action :set_checklist
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def new
  end

  def edit
  end


  # POST /checklists/5/tasks
  # task[name]='somejunk'

  # params = {checklist_id: 5, task: {name: 'somejunk'}}
  def create
    @task = Task.new(params.require(:task).permit(:name))
    @task.checklist = @checklist
    @task.user = current_user

    if @task.save
      redirect_to [@checklist], notice: "Task was saved successfully."
    else
      flash[:error] = "Error creating Task. Please try again."
      redirect_to :back
    end
  end


  def update
    @task.update(params.require(:task).permit(:name))

    if @task.save
      redirect_to [@checklist], notice: "Task was updated successfully."
    else
      flash[:error] = "Error updating task. Please try again."
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to [@checklist]
  end


  def complete
    if user_signed_in?
      @task = Task.find(params[:task_id])
      @task.finish
    end
    redirect_to [@checklist]
  end

private

  def set_checklist
    @checklist = Checklist.find(params[:checklist_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
