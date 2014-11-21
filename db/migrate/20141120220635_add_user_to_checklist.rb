class AddUserToChecklist < ActiveRecord::Migration
  def change
    add_column :checklists, :user_id, :integer
  end
end
