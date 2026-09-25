class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: :assigned_to_id,
           dependent: :nullify
  FREE_PROJECT_LIMIT = 5
  has_one_attached :avatar
  validates :name, presence: true
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :email_address, presence: true, uniqueness: {case_sensitive: false}, format:{with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  def premium?
    subcription_status == "active"
  end
  def subcription_cancel?
    subcription_status == "cancelled"
  end
  def can_create_project?
    premium? || projects.count < FREE_PROJECT_LIMIT
  end
  def free_projects_remaining
    [FREE_PROJECT_LIMIT - projects.count, 0].max
  end
end