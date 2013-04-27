namespace :db do 

	desc "Fill database with sample data"
	task populate: :environment do
		admin = Student.create!(email: "mxales@smumn.edu", password: "krokus18", password_confirmation: "krokus18")
		admin.toggle!(:admin)
	end
	
end