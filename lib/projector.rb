class Projector


	def self.calculateGpaNeededForTargetCumulativeGpa(student, target_gpa, credits_taken_this_semester) 

		all_possible_hpts = (student.credits_earned + credits_taken_this_semester.to_f) * 4.0
		
		htps_earned = student.credits_earned * student.cumulative_gpa

		gpaNeededForTargetCumulativeGpa = (target_gpa.to_f * all_possible_hpts.to_f)/(4.0*credits_taken_this_semester.to_f) - (htps_earned.to_f/credits_taken_this_semester.to_f)
			
		return gpaNeededForTargetCumulativeGpa;
		

	end
		

	def self.calculateGpaNeededForTargetMajorGpa(student, target_major_gpa, major_credits_taken_this_semester) 

		all_possible_major_hpts = (student.major_credits_earned + major_credits_taken_this_semester.to_f) * 4.0
		major_hpts_earned = student.major_credits_earned * student.major_gpa

		majorGpaNeededForTargetCumulativeGpa = (target_major_gpa.to_f * all_possible_major_hpts.to_f)/(4.0*major_credits_taken_this_semester.to_f) - (major_hpts_earned.to_f/major_credits_taken_this_semester.to_f)
			
		return majorGpaNeededForTargetCumulativeGpa;

	end


	def self.calculatePredictedCumulativeGpa(student, credits_array, predicted_grade_array, is_repeated_course_array)

		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_cumulative_hpts_earned = 0
		predicted_cumulative_credits_earned = 0


		[predicted_grade_array, credits_array, is_repeated_course_array].transpose.each do |predicted_grade, credits, is_repeated_course|
  		 
	  		if (predicted_grade.to_s != "-")
	  					predicted_cumulative_hpts_earned = credits.to_i * gradingSchema[predicted_grade.to_s] + predicted_cumulative_hpts_earned
	  					predicted_cumulative_credits_earned = credits.to_i + predicted_cumulative_credits_earned
	  			
	  		end	
  		end
	

		cumulative_hpts = predicted_cumulative_hpts_earned + student.credits_earned * student.cumulative_gpa
		all_possible_hpts = (student.credits_earned + predicted_cumulative_credits_earned) * 4.0

		predicted_cumulative_gpa =  4.0 * (cumulative_hpts / all_possible_hpts)

		return predicted_cumulative_gpa

	end


	def self.calculatePredictedMajorGpa(student, credits_array, predicted_grade_array, is_major_course_array, is_repeated_course_array)


		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_major_hpts_earned = 0
		predicted_major_credits_earned = 0


		[credits_array, predicted_grade_array, is_major_course_array, is_repeated_course_array].transpose.each do |credits, predicted_grade, is_major_course, is_repeated_course|
	  	
			if (predicted_grade.to_s != "-")
				if (is_major_course.to_i == 1) 
	  				predicted_major_hpts_earned = credits.to_i * gradingSchema[predicted_grade.to_s] + predicted_major_hpts_earned
	  				predicted_major_credits_earned = credits.to_i + predicted_major_credits_earned
	  			end
	  		end
	  	end

		cumulative_major_hpts = predicted_major_hpts_earned + student.major_credits_earned * student.major_gpa
		all_possible_major_hpts = (student.major_credits_earned + predicted_major_credits_earned) * 4.0

		predicted_major_gpa =  4.0 * (cumulative_major_hpts / all_possible_major_hpts)

		return predicted_major_gpa
	
	end


end