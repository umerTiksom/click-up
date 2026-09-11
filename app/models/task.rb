class Task < ApplicationRecord
  belongs_to :project, foreign_key: :projects_id
  belongs_to :assign_to, class_name: "User", foreign_key: :assign_to_id

  validates :tittle, presence: true, length: {minimum: 4, maximum: 50 }, uniqueness: true, on: :create
  validates :description, presence: true, length: { minimum: 4, maximum: 250 }
  validates :priority, presence: true, inclusion: { in: %w(low medium high) }
  validates :status, presence: true, inclusion: { in: %w(completed in-progress pending) }
  validates :assign_to, presence: true
end