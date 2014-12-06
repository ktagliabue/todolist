class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @tags.map(&:name)
  end
  def show
    @tag = Tag.find(params[:id])
  end
end
