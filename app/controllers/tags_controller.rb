class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name).where("lower(name) like ?", "%#{params[:term].downcase}%")
    render json: @tags.map(&:name)
  end
  def show
    @tag = Tag.find(params[:id])
  end
end
