class TasksController < ApplicationController
  
  def show
    @task = Task.find(params[:task_id])
    @checklist = Checklist.find(params[:id])
  end

  def new
    @task = Task.find(params[:task_id])
    @checklist = Checklist.new
  end

  def edit
    @task = Task.find(params[:task_id])
    @checklist = Checklist.find(params[:id])
  end

  def create
    @task = Task.find(params[:task_id])
    @checklist = current_user.posts.build(params.require(:post).permit(:title, :body))
    @checklist.Task = @task
  end

  def update
    @task = Task.find(params[:task_id])
    @checklist = Checklist.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:task_id])
    @checklist = Post.find(params[:id])
    title = @checklist.title
    authorize @checklist
  end

end
