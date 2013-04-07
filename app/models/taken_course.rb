class TakenCourse < ActiveRecord::Base

  belongs_to :student
  belongs_to :course
  attr_accessible :course_id, :grade
  validates :course_id, presence: true
  validates :student_id, presence: true
  validates :grade, presence: true

end
