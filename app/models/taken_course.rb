class TakenCourse < ActiveRecord::Base

  belongs_to :student
  attr_accessible :grade, :is_major, :credits, :name
  validates :student_id, presence: true
  validates :grade, presence: true

end
