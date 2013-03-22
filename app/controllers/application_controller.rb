class ApplicationController < ActionController::Base
  protect_from_forgery


   def calculateGPA(student)

    #remove it from root
    student.cumulative_gpa = "3.3"
    student.major_gpa = "2.0"
    return student

  end


end
