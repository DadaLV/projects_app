require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'requires email and password' do
      user = build(:user, email: nil, password: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'validates length of password' do
      user = build(:user, password: 'a' * 5)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it 'validates uniqueness of email' do
      existing_user = create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it 'has many projects' do
      association = described_class.reflect_on_association(:projects)
      expect(association.macro).to eq :has_many
    end
  end
end
