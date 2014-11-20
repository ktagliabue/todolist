class ChecklistController < ApplicationController
  def index
    @checklist = Checklist.visible_to(current_user)
  end

  def new
    @checklist = Checklist.new
  end

  def show
    @checklist = Checklist.find(params[:id])
    @tasks = @checklist.tasks.includes(:user).includes(:tasks)
  end

  def edit
    @checklist = Checklist.find(params[:id])
  end
 
  def create
    @checklist = Checklist.new(params.require(:Checklist).permit(:description, :public))

    if @checklist.save
     redirect_to @checklist, notice: "Checklist was saved successfully."
    else
     flash[:error] = "Error creating Checklist. Please try again."
     render :new
  end
   end
 

end
