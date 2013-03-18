class TakenCourse < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  attr_accessible :course_id, :grade, :student_id
end
