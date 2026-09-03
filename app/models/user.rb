class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: :assigned_to_id,
           dependent: :nullify
  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: {case_sensitive: false}
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
