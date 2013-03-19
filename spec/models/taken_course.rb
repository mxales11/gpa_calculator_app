require 'spec_helper'

describe TakenCourse do 

	before { 

	@taken_course = TakenCourse.new(student_id: 1, course_id: 1, grade: "AB") 

	}

	subject { @student }

	it { should respond_to(:student_id) }
	it { should respond_to(:course_id) }
	it { should respond_to(:course) }
	it { should respond_to(:grade) }
	it { should respond_to(:student) }
	it { should be_valid }

end