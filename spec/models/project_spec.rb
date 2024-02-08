require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it 'validates presence of name' do
      project = Project.new(description: 'Test Description')
      expect(project).to_not be_valid
      expect(project.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of description' do
      project = Project.new(name: 'Test Name')
      expect(project).to_not be_valid
      expect(project.errors[:description]).to include("can't be blank")
    end

    it 'validates length of name' do
      project = Project.new(name: 'a' * 31, description: 'Description')
      project.valid?
      expect(project.errors[:name]).to include("is too long (maximum is 30 characters)")
    end

    it 'validates length of description' do
      project = Project.new(name: 'Project 1', description: 'a' * 256)
      project.valid?
      expect(project.errors[:description]).to include("is too long (maximum is 255 characters)")
    end
  end

  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many tasks dependent on destroy' do
      association = described_class.reflect_on_association(:tasks)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end
