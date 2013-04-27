class AddNameToTakenCourses < ActiveRecord::Migration
  def change
  	add_column :taken_courses, :name, :string
  end
end
