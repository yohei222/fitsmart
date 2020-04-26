class AddSexToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sex, :integer, limit: 2, after: :status, default: 2
  end
end
