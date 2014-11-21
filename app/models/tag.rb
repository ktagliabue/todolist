class Tag < ActiveRecord::Base
  attr_accessor :name
  has_many :taggings
  has_many :checklists, through: :taggings
end
