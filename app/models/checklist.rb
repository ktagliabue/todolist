class Checklist < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  scope :visible_to, -> (user) { user ? all : where(public: true) }
end
