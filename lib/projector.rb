class Projector


	def self.changeGradingSchema(gradingSchema)

		#change global Grading schema to this global schema
		#how am I gonna change the above grading schema?

	end
	#merge those two methods later

	def self.calculateGpaNeededForTargetCumulativeGpa(student, target_gpa, credits_taken_this_semester) 

		all_possible_hpts = (student.credits_earned + creditsTakenThisSemester.to_f) * 4.0
		
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




	def self.calculatePredictedCumulativeGpa(student, creditsArray, predictedGradeArray, isRepeatedCourseArray)

		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_cumulative_hpts_earned = 0
		predicted_cumulative_credits_earned = 0


		[creditsArray, predictedGradeArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isRepeatedCourse|
  		 
  		 		if (isRepeatedCourse)

  		 		end
  					predicted_cumulative_hpts_earned = credits.to_i * gradingSchema[predictedGrade.to_s] + predicted_cumulative_hpts_earned
  					predicted_cumulative_credits_earned = credits.to_i + predicted_cumulative_credits_earned
  				
  		end
	

		cumulative_hpts = predicted_cumulative_hpts_earned + student.credits_earned * student.cumulative_gpa
		all_possible_hpts = (student.credits_earned + predicted_cumulative_credits_earned) * 4.0

		predicted_cumulative_gpa =  4.0 * (cumulative_hpts / all_possible_hpts)

		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$predictedGpa is #{predicted_cumulative_gpa}"
		return predicted_cumulative_gpa

	end


	def self.calculatePredictedMajorGpa(student, creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray)


		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_major_hpts_earned = 0
		predicted_major_credits_earned = 0


		[creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isMajorCourse, isRepeatedCourse|
  		
			if (isMajorCourse.to_i == 1) 

				if(isRepeatedCourse)

				end
  				predicted_major_hpts_earned = credits.to_i * gradingSchema[predictedGrade.to_s] + predicted_major_hpts_earned
  				predicted_major_credits_earned = credits.to_i + predicted_major_credits_earned
  			
  			end
		end

		cumulative_major_hpts = predicted_major_hpts_earned + student.major_credits_earned * student.major_gpa
		all_possible_major_hpts = (student.major_credits_earned + predicted_major_credits_earned) * 4.0

		predicted_major_gpa =  4.0 * (cumulative_major_hpts / all_possible_major_hpts)

		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$predictedGpa is #{predicted_major_gpa}"
		return predicted_major_gpa
	
	end


	def self.getArrayOfParams(parameter, arrayLength)

		logger.debug("HELPER INVOKED")
		arrayOfParams = Array.new
		length = arrayLength.to_i
		logger.debug(length)


		length.to_i.times do |i|

	   		logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"
			logger.debug "LOOP"
		
			logger.debug "EXPECTED PARAMS"
			logger.debug("#{parameter}#{i.to_s}")
			logger.debug(params[:projection][:"#{parameter}#{i.to_s}"])
   			arrayOfParams.push(params[:projection][:"#{parameter}#{i.to_s}"])

	   		logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"
			logger.debug "WAS PUSHED"

   		end

	   		logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"
			logger.debug "ARRAY OF PARAMS is  #{arrayOfParams}"

		return arrayOfParams

	end



end