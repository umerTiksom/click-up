class RemoveActiveFromProjects < ActiveRecord::Migration[8.1]
  def change
    remove_column :projects, :active, :boolean
  end
end
