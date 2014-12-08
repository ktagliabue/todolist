class AddCompleteToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :complete, :integer, default: false
  end
end
