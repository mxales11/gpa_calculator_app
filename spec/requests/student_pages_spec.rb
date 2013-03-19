require 'spec_helper'

describe "Student pages" do 

	subject { page }

	let(:submit) { "Add taken course" }

	before { 

	@student = Student.create(email: "student@example.com", password: "foobar", password_confirmation: "foobar") 
	@courses = Course.create([{ name: 'Probability', credits: 3}, { name: 'Web Systems', credits: 3}, { name: 'Linear Algebra', credits: 3}, { name: 'Bible and Belief', credits: 3}, { name: 'Modern Dance', credits: 1}, { name: 'Ceramics', credits: 3}, { name: 'Calculus III', credits: 4}, { name: 'Intro to Literature', credits: 3}, { name: 'Modern Movies', credits: 3}, { name: 'Into to Geography', credits: 3}])
	@taken_course = TakenCourse.new

	visit new_student_taken_course_path(@student, @taken_course)

	}


	# association tests

		
	describe "with valid information" do

		before do
			fill_in "student_id", with: "1"
			fill_in "course_id", with: "2"
			fill_in "grade", with: "AB"
		end

		it "should create taken course" do
				expect { click_button submit }.to change(TakenCourse, :count).by(1)
		end
	end

	describe "with missing grade" do 

		before do
			fill_in "student_id", with: "1"
			fill_in "course_id", with: "2"
		end

		it "should not create taken course" do
				expect { click_button submit }.not_to change(TakenCourse, :count)
		end
	end


	describe "with missing student_id" do 

		before do
			fill_in "grade", with: "AB"
			fill_in "course_id", with: "2"
		end

		it "should not create taken course" do
				expect { click_button submit }.not_to change(TakenCourse, :count)
		end
	end


	describe "with missing course_id" do 

		before do
			fill_in "student_id", with: "1"
			fill_in "grade", with: "AB"
		end

		it "should not create taken course" do
				expect { click_button submit }.not_to change(TakenCourse, :count)
		end
	end

end
