class TakenCourse < ActiveRecord::Migration
   def change
  	add_column :taken_courses, :student_id, :integer
  	add_column :taken_courses, :course_id, :integer
  	add_column :taken_courses, :grade, :string
  end

end
