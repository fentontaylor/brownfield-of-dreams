require 'rails_helper'

describe "'Classroom' tutorials are restricted" do
  before :each do
    @non_classroom = create(:tutorial, classroom: false)
    @vid_1 = create(:video, tutorial: @non_classroom)

    @classroom = create(:tutorial, classroom: true)
    @vid_2 = create(:video, tutorial: @non_classroom)
  end

  context 'As a non-logged-in visitor' do
    it 'I CANNOT see videos marked as "classroom"' do
      visit '/'

      expect(page).to have_css('.tutorial', count: 1)
      expect(page).to have_content(@non_classroom.title)
    end
  end

  context 'As a logged-in user' do
    it 'I CAN see videos marked as "classroom"' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'

      expect(page).to have_css('.tutorial', count: 2)
      expect(page).to have_content(@non_classroom.title)
      expect(page).to have_content(@classroom.title)
    end
  end
end
