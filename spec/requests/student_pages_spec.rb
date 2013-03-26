require 'spec_helper'

describe "Student pages" do 

	subject { page }


	describe "profile page" do

		let(:student) { FactoryGirl.create(:student) }
		before { visit student_path(student) }

		it { should have_selector('h1', text: student.email) }
		it { should have_selector('title', title: "Student") }
	end
		

	describe "signup" do

		before { visit signup_path }
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a student" do
				expect { click_button submit }.not_to change(Student, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Email", with: "john15@yahoo.com"
				fill_in "Password", with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end

			it "should create a student" do
				expect { click_button submit}. to change(Student, :count).by(1)
			end
		end
	end



	


=begin TESTS FOR ADDING TAKEN COURSES:
	describe "signup page" do

		it { should have_selector('h1', text: 'Sign up') }
		it { should have_selector('title', text: 'Sign up') }
	end

		before { visit signup_path }
		

	describe "add taken courses page" do

		let(:student) { FactoryGirl.create(:student) }
		let(:course) { FactoryGirl.create(:course) }
		let(:submit) { "Add taken course" }

		before do
			visit new_student_taken_course_path(student, taken_course)
		end

			describe "with valid information" do

				before do
					fill_in "course_id", with: 3
					fill_in "grade", with: "AB"
				end
				

				it "should create taken course" do
						expect { click_button submit }.to change(TakenCourse, :count).by(1)
				end
			end

			describe "with missing grade" do 

				before do
					fill_in "course_id", with: 2
				end

				it "should not create taken course" do
						expect { click_button submit }.not_to change(TakenCourse, :count)
				end
			end


			describe "with missing course_id" do 

				before do
					fill_in "grade", with: "AB"
				end

				it "should not create taken course" do
						expect { click_button submit }.not_to change(TakenCourse, :count)
				end
			end
		end
=end

end