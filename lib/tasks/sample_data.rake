namespace :db do 

	desc "Fill database with sample data"
	task populate: :environment do
		admin = Student.create!(email: "mxales@smumn.edu", password: "krokus18", password_confirmation: "krokus18", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
		admin.toggle!(:admin)

		John = Student.create!(email: "john@smumn.edu", password: "john22", password_confirmation: "john22", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0 )
		Trevor = Student.create!(email: "trevor@smumn.edu", password: "trevor22", password_confirmation: "trevor22", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
		Sabrina = Student.create!(email: "sabrina@smumn.edu", password: "sabrina22", password_confirmation: "sabrina22",major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
		Mary = Student.create!(email: "mary@smumn.edu", password: "mary22", password_confirmation: "mary22", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
		Jeremy = Student.create!(email: "jeremy@smumn.edu", password: "jeremy22", password_confirmation: "jeremy22", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
		Daniela = Student.create!(email: "daniela@smumn.edu", password: "daniela22", password_confirmation: "daniela22", major_credits_earned: 0, credits_earned: 0, cumulative_gpa: 0.0, major_gpa: 0.0)
	end
	
end