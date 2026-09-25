class AddSubscriptionCancelAtToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :subscription_cancel_at, :datetime
  end
end
