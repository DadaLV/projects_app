class Task < ApplicationRecord

  STATUS = [
    NEW = 'new',
    IN_PROGRESS = 'in_progress',
    COMPLETED = 'completed'
  ]

  belongs_to :project

  validates :name, :status, presence: true
  validates :name, length: { maximum: 30 }
  validates :description, length: { maximum: 255 }
  validates :status, inclusion: { in: STATUS }
end
