require 'rails_helper'

feature 'Checklist Management' do
  feature 'Creating a checklist' do
    context 'With an existing user' do
      before do
        User.create!(email: 'a@a.com', password: '12345678')
      end

      scenario 'A signed-in user can create a checklist' do
        visit '/'
        click_link 'Sign In'
        fill_in 'Email', with: 'a@a.com'
        fill_in 'Password', with: '12345678'
        click_button 'Log in'
        
        visit '/checklists'
        fill_in 'Name', with: 'my checklist'
        click_button 'Create Checklist'

        visit '/checklists'
        expect(page).to have_content('my checklist')
      end
    end

    context 'Without an existing user' do
      scenario 'A signed-out user cannot create a checklist' do
        visit '/checklists'
        fill_in 'Name', with: 'my checklist'
        click_button 'Create Checklist'

        visit '/checklists'
        expect(page).to_not have_content('my checklist')
      end
    end
  end
end

feature 'Deletion Management' do
  feature 'Deleting a checklist' do
    context 'With an existing user' do
      before do
        User.create!(email: 'a@a.com', password: '12345678')
        Checklist.create!(name: 'test', user_id: User.last.id)
      end

      scenario 'A signed-in user can delete a checklist' do
        visit '/'
        click_link 'Sign In'
        fill_in 'Email', with: 'a@a.com'
        fill_in 'Password', with: '12345678'
        click_button 'Log in'
        
        visit '/checklists'
        click_link 'destroy'

        expect(Checklist.all.count).to eq(0)
      end

      scenario 'A signed-out user cannot delete a checklist' do
        visit '/checklists'
        expect(page).to_not have_link('destroy')
      end
    end
  end
end
