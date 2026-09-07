class Task < ApplicationRecord
  belongs_to :project, foreign_key: :projects_id
  belongs_to :assign_to, class_name: "User"
  belongs_to :user
  validates :tittle, presence: true
  validates :description, presence: true
  validates :priority, presence: true, inclusion: { in: %w(low medium high) }
  validates :status, presence: true,inclusion: { in: %w(completed in-progress pending) }
  validates :assign_to, presence: true
end
