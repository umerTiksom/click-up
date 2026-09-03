class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :projects, null: false, foreign_key: true
      t.string :tittle
      t.text :description
      t.string :priority
      t.string :status
      t.references :assign_to, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
