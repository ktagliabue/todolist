class Api::V1::ChecklistsController < ApplicationController
  # params = {user_id: 1, checklist: {name: 'a checklist'}}

  def create
    @user = User.find(params[:user_id])
    if @user.valid_password?(params[:password])
      # @checklist = Checklist.new(name: params[:checklist][:name])
      @checklist = Checklist.new(params.require(:checklist).permit(:name))
      @checklist.user = @user
      @checklist.save!
      head 200
    elsif
      head 500
    end


  end

  def index 
    @user = User.find(params[:user_id])
    @checklists = @user.checklists
    render json: @user.checklists
  end

  def destroy
    @checklist = Checklist.find_or_initialize_by(id: params[:id])
    @checklist.delete
    head 200
  end

  def update
    @user = User.find(params[:user_id])
    @checklist = Checklist.find_or_initialize_by(id: params[:id])
    @checklist.update(params.require(:checklist).permit(:name))
    head 200
  end

end
