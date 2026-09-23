class AddSubcriptionToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_subcription_id, :string
    add_column :users, :subcription_status, :string
  end
end
