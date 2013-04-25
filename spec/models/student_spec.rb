require 'spec_helper'

describe Student do 

	before do 
		@student = Student.new(email: "student@yahoo.com", password:"foobar", password_confirmation: "foobar")
	end
	
	subject { @student }

	it { should respond_to(:email) }
	it { should respond_to(:major_gpa) }
	it { should respond_to(:cumulative_gpa) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:credits_earned) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:taken_courses) }
	it { should respond_to(:remember_token) }


	it { should respond_to(:admin) }
	it { should_not be_admin }
	
	it{ should be_valid }
	

	describe "with admin attribute set to 'true'" do
		before { @student.toggle!(:admin) }
		it {should be_admin }
	end
	
	describe "remember_token" do
		before { @student.save }
		its(:remember_token) { should_not be_blank }
	end
	
    it "should exist" do
    	@student.save
		Student.find(@student.id).email.should == "student@yahoo.com"
    end

    it "should have 2 taken courses" do

    		@student.save
    		@student.taken_courses.create!(course_id: 1, grade: "AB")
			@student.taken_courses.create!(course_id: 2, grade: "CD")
			@student.taken_courses(:force_reload=>:true).size.should == 2
    end
    
	describe "when email is not present" do
		before { @student.email = " " }
		it { should_not be_valid }
	end

	describe "when email is too long" do
		before { @student.email = "a" * 31 }
		it { should_not be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[student@foo,com student_at_foo.org example.student@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@student.email = invalid_address
				@student.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[student@foo.COM A_US-ER@f.b.org frst.lst@foo.js a+b@baz.cn]
			addresses.each do |valid_address|
				@student.email = valid_address
				@student.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			student_with_same_email = @student.dup
			student_with_same_email.email = @student.email.upcase
			student_with_same_email.save
		end

		it { should_not be_valid }
	end


	#password tests

	describe "when password is not present" do
		before { @student.password = @student.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password doesn't match confirmation" do
		before { @student.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @student.password_confirmation = nil }
		it { should_not be_valid } 
	end

	describe "with a password that's too short" do
		before { @student.password = @student.password_confirmation = 'a' * 5 }
		it { should be_invalid }
	end



	#authenticate
	describe "return value of authenticate method" do
		before { @student.save }
		let(:found_student) { Student.find_by_email(@student.email) }

		describe "with valid password" do
			it { should == found_student.authenticate(@student.password) }
		end

		describe "with invalid password" do
			let(:student_for_invalid_password) { found_student.authenticate("invalid") }

			it { should_not == student_for_invalid_password }
			specify { student_for_invalid_password.should be_false }
		end
	end

end
		
