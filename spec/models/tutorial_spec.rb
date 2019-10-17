# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it { should have_many :videos }
    it { should have_many(:user_videos).through(:videos) }
    it { should have_many(:users).through(:user_videos) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :thumbnail }
  end
end
