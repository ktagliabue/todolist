class Api::V1::TasksController < ApplicationController
  # params = {checklist_id: 5, task: {name: 'somejunk'}}

  def create
    @task = Task.new(params.require(:task).permit(:name))
    @task.checklist = @checklist
    @task.user = @user
    @user = User.find(params[:user_id])
    @task.save!
    head 200
  end
  
  def destroy
    @task = Task.find_or_initialize_by(id: params[:id])
    @task.delete
    head 200
  end

  def update
    @user = User.find(params[:user_id])
    @task = Task.find_or_initialize_by(id: params[:id])
    @task.update(params.require(:task).permit(:name))
    head 200
  end

end
