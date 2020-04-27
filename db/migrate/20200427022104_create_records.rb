class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :micropost, foreign_key: true
      t.integer :exercise_id
      t.integer :weight
      t.integer :times
      t.integer :sets
      t.timestamps
      t.index :exercise_id
    end
  end
end
