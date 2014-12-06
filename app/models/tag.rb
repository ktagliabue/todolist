class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :checklists, through: :taggings

  def index
  end

end
