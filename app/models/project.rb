class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, length: { maximum: 30 }
  validates :description, length: { maximum: 255 }
end
