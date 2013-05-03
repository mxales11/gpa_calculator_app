require 'spec_helper'

describe "Student pages" do 

	subject { page }
	let(:student) { FactoryGirl.create(:student) }


	describe "profile page" do

		before { visit student_path(student) }

		it { should have_selector('title', title: student.email) }
	end


	describe "projection pages" do

		describe "calculating predicted cumulative GPA" do
			let(:submit) {"Calculate GPA needed this semester to have target Cumulative GPA" }
			let(:toggle) {"Target Cumulative GPA" }

			before do
				click_button toggle
				fill_in "Desired cumulative GPA", with: 4.0
				fill_in "Credits taken this semester", with: 18
				click_button submit
			end

				it { should have_selector('h5', text: "Cumulative GPA you need this semester for target cumulative GPA:" )}
				it { should have_text("4.0") }
				it { should have_text("4.0") }
		
		end
	
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
				fill_in "Password Confirmation", with: "foobar"
			end

			it "should create a student" do
				expect { click_button submit}. to change(Student, :count).by(1)
			end


			describe "after saving the student" do
				before { click_button submit }
				let(:student) { Student.find_by_email('student@yahoo.com') }

				it { should have_selector('title', text: student.email) }
				
				it { should have_link('Sign out') }
			end
		end
	end
end


	

