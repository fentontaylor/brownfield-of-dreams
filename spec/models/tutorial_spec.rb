require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'relationships' do
    it {should have_many :videos }
    it {should have_many(:user_videos).through(:videos) }
    it {should have_many(:users).through(:user_videos) }
  end
end
