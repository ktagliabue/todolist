require 'rails_helper'

describe 'Checklists API' do
  describe '#create' do
    context 'for an existing user' do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }

      it "creates the checklist belonging to that user" do
        post "/api/v1/users/#{user.id}/checklists", {checklist: {name: 'a checklist'}}
        expect(Checklist.count).to eq(1)
        expect(user.checklists.count).to eq(1)
        expect(user.checklists.first.name).to eq('a checklist')
      end
    end
  end 

  describe '#update' do
    context "for an existing user's existing checklist" do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create(name: 'checklist 1') }

      it 'updates the checklist' do
        put "/api/v1/users/#{user.id}/checklists/#{checklist.id}", {checklist: {name: 'checklist 2'}}
        expect(user.checklists.first.name).to eq('checklist 2')
      end
    end
  end

  describe '#destroy' do
    context "for an existing user's existing checklist" do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist){ user.checklists.create(name: 'checklist 1') }

      it 'deletes the checklist' do
        delete "/api/v1/users/#{user.id}/checklists/#{checklist.id}"
        expect(user.checklists.count).to eq(0)
      end
    end
  end

  describe '#index' do
    context 'for an existing user with some checklists' do
      let!(:user){ User.create(email: 'a@a.com', password: '12345678') }
      let!(:checklist1){  user.checklists.create(name: 'Checklist 1')}
      let!(:checklist2){  user.checklists.create(name: 'Checklist 2')}

      it "returns the checklists' names" do
        get "/api/v1/users/#{user.id}/checklists"
        # ['checklists': {name: 'Checklist 1'}, {name: 'Checklist'}]
        expect(response.body).to include(checklist1.name)
        expect(response.body).to include(checklist2.name)
      end
    end
  end
end
