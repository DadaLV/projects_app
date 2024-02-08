class Task < ApplicationRecord

  STATUS = [
    NEW = 'new',
    IN_PROGRESS = 'in_progress',
    COMPLETED = 'completed'
  ]

  belongs_to :project

  validates :name, :status, presence: true
end
