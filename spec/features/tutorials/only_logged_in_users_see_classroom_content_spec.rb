require 'rails_helper'

describe "'Classroom' tutorials are restricted" do
  before :each do
    @non_classroom = create(:tutorial, classroom: false)
    @vid_1 = create(:video, tutorial: @non_classroom)

    @classroom = create(:tutorial, classroom: true)
    @vid_2 = create(:video, tutorial: @classroom)
  end

  context 'As a non-logged-in visitor' do
    it 'I CANNOT see videos marked as "classroom"' do
      visit '/'

      expect(page).to have_css('.tutorial', count: 1)
      expect(page).to have_content(@non_classroom.title)
    end

    it 'I CANNOT manually visit a restricted tutorial' do
      visit "/tutorials/#{@non_classroom.id}"

      expect(page).to have_content(@non_classroom.title)
      expect(page).to have_css('#player')

      visit "/tutorials/#{@classroom.id}"
      expect(page).to have_content("You must be logged in to view this content.")
      expect(page).to have_content("Please sign in or create a free account.")
      expect(page).to_not have_css('#player')
    end
  end

  context 'As a logged-in user' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it 'I CAN see videos marked as "classroom"' do
      visit '/'

      expect(page).to have_css('.tutorial', count: 2)
      expect(page).to have_content(@non_classroom.title)
      expect(page).to have_content(@classroom.title)
    end

    it 'I CAN manually visit a restricted tutorial' do
      visit "/tutorials/#{@non_classroom.id}"

      expect(page).to have_content(@non_classroom.title)
      expect(page).to have_css('#player')

      visit "/tutorials/#{@classroom.id}"

      expect(page).to have_content(@classroom.title)
      expect(page).to have_css('#player')
    end
  end
end
