require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validations' do
    it 'requires name' do
      task = Task.new
      task.valid?
      expect(task.errors[:name]).to include("can't be blank")
    end

    it 'validates length of name' do
      task = Task.new(name: 'a' * 31, status: 'new', project: Project.new(name: 'Project', description: 'Description'))
      task.valid?
      expect(task.errors[:name]).to include("is too long (maximum is 30 characters)")
    end

    it 'validates status inclusion' do
      task = Task.new(name: 'Task', status: 'invalid', project: Project.new(name: 'Project', description: 'Description'))
      task.valid?
      expect(task.errors[:status]).to include("is not included in the list")
    end
  end

  describe 'associations' do
    it 'belongs to project' do
      association = described_class.reflect_on_association(:project)
      expect(association.macro).to eq :belongs_to
    end
  end
end
