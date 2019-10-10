require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password_digest)}
  end

  describe 'roles' do
    it 'can be created as default user without token' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)
      expect(user).to be_an_instance_of(User)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as default user with token' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, token: 'randomstring')

      expect(user).to be_an_instance_of(User)
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
end
