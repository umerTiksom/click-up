class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy, foreign_key: :projects_id
  validates :name, presence: true
  validates :description, presence: true
end
