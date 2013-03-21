require 'spec_helper'

describe TakenCourse do 

	before { 

	@student = Student.create(email: "student@yahoo.com", password: "foobar", password_confirmation: "foobar")
	@courses = Course.create([{ name: 'Probability', credits: 3}, { name: 'Web Systems', credits: 3}, { name: 'Linear Algebra', credits: 3}, { name: 'Bible and Belief', credits: 3}, { name: 'Modern Dance', credits: 1}, { name: 'Ceramics', credits: 3}, { name: 'Calculus III', credits: 4}, { name: 'Intro to Literature', credits: 3}, { name: 'Modern Movies', credits: 3}, { name: 'Into to Geography', credits: 3}])
	
	}

	subject { @student }

	it { should respond_to(:student_id) }
	it { should respond_to(:course_id) }
	it { should respond_to(:course) }
	it { should respond_to(:grade) }
	it { should respond_to(:student) }
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