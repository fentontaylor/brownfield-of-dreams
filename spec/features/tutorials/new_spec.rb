require 'rails_helper'
# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."

describe 'As an admin' do
  describe 'When I visit /admin/tutorials/new' do
    context 'I fill in the form correctly and click Save' do
      it 'Creates a new tutorial' do
        admin = create(:user, role: 1)
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(admin)

        visit admin_dashboard_path

        click_link 'New Tutorial'

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
      
    end
  end
end
