require 'spec_helper'

describe TakenCourse do 

	before do 
		@student = Student.new(email: "student@yahoo.com", password:"foobar", password_confirmation: "foobar")
		@taken_course = @student.taken_courses.build
		@taken_courses.grade = 'A'
		@taken_course.name = 'Probability'
		@taken_course.credits = 3
		@taken_course = @student.taken_courses.build(params[:taken_course])
	end

	subject { @taken_course }

	it { should respond_to(:student_id) }
	it { should respond_to(:grade) }
	it { should respond_to(:student) }
	it { should respond_to(:name) }
	it { should respond_to(:credits) }
	it { should respond_to(:grade) }
	it { should be_valid }

	describe "when student_id is not present" do
		before { @taken_course.student_id = nil }
		it { should_not be_valid } 
	end

	describe "accessible attributes" do
		it "should not allow access to student_id" do
			expect do
				TakenCourse.new(student_id: @student.id, course_id: 1, grade: "A")
			end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

end