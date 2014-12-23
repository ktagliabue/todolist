require 'rails_helper'

describe 'Tasks API' do
  context 'with a user and a checklist' do
    let!(:user){ User.create!(email: 'a@a.com', password: '12345678') }
    let!(:checklist){ user.checklists.create(name: 'a checklist') }

    describe '#create' do
      it 'creates a task belonging to that checklist' do
        post "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks", {task: {name: 'a task'}}
        expect(checklist.tasks.count).to eq(1)
      end
    end

    context 'with some tasks' do
      before { 5.times { |n| checklist.tasks.create!(name: "tasks #{n}") } }

      describe '#index' do
        it "returns the checklist's tasks" do
          get "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks"
          expect(response.body).to eq(user.checklists.to_json)
        end
      end
    end

    context 'with a task' do
      let!(:task){ checklist.tasks.create!(name: 'task 1') }

      describe '#update' do
        it 'updates the task' do
          patch "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{task.id}", {task: {name: 'task 2'}}
          expect(task.reload.name).to eq('task 2')
        end
      end

      describe '#destroy' do
        it 'deletes the checklist' do
          delete "/api/v1/users/#{user.id}/checklists/#{checklist.id}/tasks/#{task.id}"
          expect(checklist.tasks.count).to eq(0)
        end
      end
    end
  end
end
