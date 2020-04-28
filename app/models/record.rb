class Record < ApplicationRecord
  belongs_to :micropost
  validates :exercise_id, presence: true
  validates :weight, presence: true
  validates :times, presence: true
  validates :sets, presence: true
end
