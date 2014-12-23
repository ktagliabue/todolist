require 'rails_helper'

describe 'Checklists API' do
  context 'with a user' do
    let!(:user){ User.create!(email: 'a@a.com', password: '12345678') }

    describe '#create' do
      it 'creates a checklist belonging to that user' do
        post "/api/v1/users/#{user.id}/checklists", {checklist: {name: 'a checklist'}}
        expect(user.checklists.count).to eq(1)
      end
    end

    context 'with some checklists' do
      before { 5.times { |n| user.checklists.create!(name: "checklist #{n}") } }

      describe '#index' do
        it "returns the user's checklists" do
          get "/api/v1/users/#{user.id}/checklists"
          expect(response.body).to eq(user.checklists.to_json)
        end
      end
    end

    context 'with a checklist' do
      let!(:checklist){ user.checklists.create!(name: 'checklist 1') }

      describe '#update' do
        it 'updates the checklist' do
          patch "/api/v1/users/#{user.id}/checklists/#{checklist.id}", {checklist: {name: 'checklist 2'}}
          expect(checklist.reload.name).to eq('checklist 2')
        end
      end

      describe '#destroy' do
        it 'deletes the checklist' do
          delete "/api/v1/users/#{user.id}/checklists/#{checklist.id}"
          expect(user.checklists.count).to eq(0)
        end
      end
    end
  end
end
