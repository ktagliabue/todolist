class Api::V1::TasksController < ApplicationController
  # params = {checklist_id: 5, task: {name: 'somejunk'}}

  def create
    @checklist = Checklist.find(params[:checklist_id])
    @task = Task.create!(checklist_id: @checklist.id, name:params.require(:task).permit(:name)["name"])
    head 200
  end

  def index 
    @checklist = Checklist.find(params[:checklist_id])
    render json: @checklist.tasks.to_json
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
