class ApplicationController < ActionController::Base
  protect_from_forgery


   def calculateGPA(student)

    	student.update_attributes(major_gpa: 1.5, cumulative_gpa: 7.3)  
	end


end
