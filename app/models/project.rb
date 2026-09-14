class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy, foreign_key: :projects_id
  validates :name, presence: true, length:{minimum:5,maximum: 50}, uniqueness: {scope: :user_id, message: "project must be unique for the owner"}
  validates :description, presence: true, length:{minimum:5,maximum: 500}
end
