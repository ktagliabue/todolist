class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @checklist = Checklist.tagged_with(params[:tag])
    else
      @checklist = Checklist.all
    end
  end

  def show
  end

  def new
    @checklist = Checklist.new
  end

  def edit
  end

  def create
    if user_signed_in?
      @checklist = Checklist.create
    end
    @checklist = Checklist.new(params.require(:checklist).permit(:name, :tag_list))
    @checklist.user = current_user

    if @checklist.save
      redirect_to @checklist, notice: "Checklist was saved successfully."
    else
      flash[:error] = "Error creating Checklist. Please try again."
      redirect_to :back
    end
  end

  def update
    @checklist.update(params.require(:checklist).permit(:name))

    if @checklist.save
      redirect_to @checklist, notice: "Checklist was updated successfully."
    else
      flash[:error] = "Error updating Checklist. Please try again."
      render :edit
    end
  end

  def destroy
    if user_signed_in?
      @checklist.destroy
    end
    redirect_to checklists_path
  end

  def set_checklist
    @checklist = Checklist.find(params[:id])
  end
end
