require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_numericality_of(:position).allow_nil}
  end
end
