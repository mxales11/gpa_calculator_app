class TakenCourse < ActiveRecord::Base
  belongs_to :student, touch: true
  belongs_to :course, touch: true
  attr_accessible :course_id, :grade

  validates :course_id, presence: true
  validates :student_id, presence: true
  validates :grade, presence: true

end
