require 'rails_helper'

describe 'Tasks API' do
  describe '#create' do
    context "for an existing user's existing checklist" do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create(name: 'a checklist') }
      let!(:tasks){ user.tasks.create(name: 'a task') }

      it "creates the task for that checklist" do
        post "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/", {task: {name: 'a task'}}
        expect(user.tasks.first.name).to eq('a task')
      end
    end
  end

  describe '#update' do
    context "for an existing user's existing task" do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create(name: 'checklist 1') }
      let!(:tasks){ user.tasks.create(name: 'a task') }

      it 'updates the task' do
        put "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{tasks.id}", {task: {name: 'another task'}}
        expect(user.tasks.first.name).to eq('another task')
      end
    end
  end

  describe '#destroy' do
    context "for an existing user's existing task" do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create(name: 'checklist 1') }
      let!(:tasks){ user.tasks.create(name: 'a task') }

      it 'deletes the task' do
        delete "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{tasks.id}"
        expect(user.tasks.count).to eq(0)
      end
    end
  end
end