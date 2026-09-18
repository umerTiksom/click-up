class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy, foreign_key: :projects_id
  validates :name, presence: true, length:{minimum:5,maximum: 50}, uniqueness: {scope: :user_id, message: "project must be unique for the owner"}
  validates :description, presence: true, length:{minimum:5,maximum: 500}
  before_save :before_save_message
  after_save :after_save_message
  has_many_attached :files
  scope :search_project, ->(search){ where("name LIKE ?", "%#{search}%") if search.present? }

  scope :left_joins_project, ->(user){
    left_joins(:tasks).where("projects.user_id = :user_id OR tasks.assign_to_id = :user_id", user_id: user.id)
                      .distinct
  }
  scope :show_specific_project, ->(user,project_id){
    left_joins(:tasks).where("projects.id= :project_id AND (projects.user_id = :user_id OR tasks.assign_to_id = :user_id)",project_id: project_id,user_id: user.id).distinct
  }
  private
  def before_save_message
    Rails.logger.info "Before project saved"
  end
  def after_save_message
    Rails.logger.info "after Project saved"
  end
end
