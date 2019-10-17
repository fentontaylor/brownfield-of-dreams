require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:user_name) }
  end
end
