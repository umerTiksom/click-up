class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: :assigned_to_id,
           dependent: :nullify
  validates :name, presence: true
  validates :password_digest, presence: true,length: {minimum: 6, maximum: 20}, on: :create
  validates :email_address, presence: true, uniqueness: {case_sensitive: false}, format:{with: URI::MailTo::EMAIL_REGEXP}
  normalizes :email_address, with: ->(e) { e.strip.downcase }

end