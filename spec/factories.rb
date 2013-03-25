FactoryGirl.define do 

	factory :student do
		email "student@yahoo.com"
		password "foobar"
		password_confirmation "foobar"
	end

	factory :course do
		name "Probability"
		credits 3
	end

end