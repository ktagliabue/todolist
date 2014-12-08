class Task < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user
  belongs_to :checklist
  scope :incomplete, -> { where(complete: false) }
  default_scope { where(complete: false) }
  validates :name, presence: true

  def self.prune_old_records
    Task.where("created_at <= ?", Time.now - 30.days).destroy_all
  end

  def finish
    update!(complete: true)
  end
end

