class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :checklists

  def self.prune_old_records
    Task.where("created_at <= ?", Time.now - 30.days).destroy_all
  end
end

