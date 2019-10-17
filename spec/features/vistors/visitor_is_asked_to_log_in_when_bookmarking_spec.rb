# frozen_string_literal: true

require 'rails_helper'

describe 'A visitor' do
  context 'clicks "Bookmark" on tutorial video' do
    it 'does not bookmark the page and tells them to log in' do
      tutorial = create(:tutorial)
      video = create(:video, tutorial_id: tutorial.id)

      visit tutorial_path(tutorial)

      within '.bookmark' do
        click_button 'Bookmark'
      end

      expect(current_path).to eq(tutorial_path(tutorial))
    end
  end
end
