class Course < ActiveRecord::Base
  attr_accessible :credits, :name
  has_many :taken_courses
  has_many :students, :through => :taken_courses
end
