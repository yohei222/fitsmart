module MicropostsHelper

  def duplicate_exercise?(micropost)
    records = micropost.records
    array = records.map{|record| record.exercise_id }
    unless (array.size - array.uniq.size) == 0
      return true
    end
  end

end
