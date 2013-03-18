class CourseTaken < ActiveRecord::Base
  attr_accessible :course_id, :grade, :student_id
end
