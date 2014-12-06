class Checklist < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings 
  validates :name, length: {minimum: 1}

  def self.tagged_with(name)
    Tag.find_by(name: name).checklists
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    self.tags.map(&:name).join(",")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.find_or_create_by(name: n.strip)
    end
  end
end
