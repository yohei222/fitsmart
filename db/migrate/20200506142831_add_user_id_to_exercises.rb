class AddUserIdToExercises < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :user_id, :integer, default: 0, after: :id
  end
end
