require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit /admin/tutorials/new' do
    before :each do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(admin)

      visit admin_dashboard_path

      click_link 'New Tutorial'
    end

    context 'I fill in the form correctly and click Save' do
      it 'Creates a new tutorial' do
        expect(current_path).to eq '/admin/tutorials/new'

        title = 'New Tutorial Title'
        description = 'This is a description'
        thumbnail = 'thumbnail.jpg'

        fill_in 'Title', with: title
        fill_in 'Description', with: description
        fill_in 'Thumbnail', with: thumbnail

        click_button 'Save'

        tutorial = Tutorial.last

        expect(current_path).to eq tutorial_path(tutorial)
        expect(page).to have_content("Successfully created tutorial.")
        expect(page).to have_content(title)
      end
    end

    context "I don't fill in the fields and click save" do
      it 'Does not save, but gives a flash message with the fields I missed' do
        click_button 'Save'

        expect(page).to have_content("Title can't be blank, Description can't be blank, and Thumbnail can't be blank")
      end
    end
  end
end
