class AddCreditsToTakenCourses < ActiveRecord::Migration
  def change
  	add_column :taken_courses, :credits, :integer
  end
end

