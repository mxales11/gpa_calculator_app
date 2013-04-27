class RemoveCourseidFromTakenCourses < ActiveRecord::Migration
    def change
  		remove_column :taken_courses, :course_id
  	end

end
