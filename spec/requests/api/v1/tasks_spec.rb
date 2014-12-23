require 'rails_helper'

describe 'Tasks API' do
  describe '#create' do
    context "for an existing user's existing checklist" do
      let!(:user){ User.create!(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create!(name: 'a checklist') }

      it "creates a task belonging to that checklist" do
        post "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks", {task: {name: 'a task'}}
        expect(checklist.tasks.count).to eq(1)
      end
    end
  end 

  describe '#update' do
    context "for an existing user's existing checklist's existing task" do
      let!(:user){ User.create!(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create!(name: 'a checklist') }
      let!(:task){ checklist.tasks.create!(name: 'task 1') }

      it 'updates the checklist' do
        patch "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{task.id}", {task: {name: 'task 2'}}
        expect(checklist.tasks.first.name).to eq('task 2')
      end
    end
  end

  describe '#destroy' do
    context "for an existing user's existing checklist's existing task" do
      let!(:user){ User.create!(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create!(name: 'a checklist') }
      let!(:task){ checklist.tasks.create!(name: 'task 1') }

      it 'deletes the checklist' do
        delete "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{task.id}"
        expect(checklist.tasks.count).to eq(0)
      end
    end
  end
end
