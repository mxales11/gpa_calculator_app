class TakenCourse < ActiveRecord::Base

  belongs_to :student
  belongs_to :course
  attr_accessible :course_id, :grade, :is_major, :course_name
  validates :course_id, presence: true
  validates :student_id, presence: true
  validates :grade, presence: true

end
