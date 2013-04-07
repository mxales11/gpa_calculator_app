class CreateTakenCourses < ActiveRecord::Migration
  def change
    create_table :taken_courses do |t|
      t.integer :student_id
      t.integer :course_id
      t.string :grade
      t.boolean :is_major

      t.timestamps
    end
  end
end
