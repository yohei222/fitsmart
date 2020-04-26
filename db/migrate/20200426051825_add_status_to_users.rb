class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :integer, default: 1, null: false, limit: 1, after: :id
  end
end
