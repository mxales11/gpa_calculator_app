module ProjectionsHelper



	def changeGradingSchema(gradingSchema)

		#change global Grading schema to this global schema
		#how am I gonna change the above grading schema?

	end
	#merge those two methods later

	def calculateGpaNeededForTargetCumulativeGpa(credits_earned, cumulative_gpa, targetGpa, creditsTakenThisSemester) 

		all_possible_hpts = (credits_earned + creditsTakenThisSemester) * 4.0
		htps_earned = credits_earned * cumulative_gpa

		gpaNeededForTargetCumulativeGpa = (targetGpa * all_possible_hpts)/(4*creditsTakenThisSemester) - (htps_earned/creditsTakenThisSemester)
			
		return gpaNeededForTargetCumulativeGpa;

	end
		


	def calculateGpaNeededForTargetMajorGpa(major_credits_earned, major_gpa, targetGpa, majorCreditsTakenThisSemester) 

		all_possible_major_hpts = (major_credits_earned + majorCreditsTakenThisSemester) * 4.0
		htps_earned = major_credits_earned * major_gpa

		majorGpaNeededForTargetCumulativeGpa = (targetGpa * all_possible_major_hpts)/(4*majorCreditsTakenThisSemester) - (major_htps_earned/majorCreditsTakenThisSemester)
			
		return majorGpaNeededForTargetCumulativeGpa;

	end




	def calculatePredictedCumulativeGpa(credits_earned, cumulative_gpa, creditsArray, predictedGradeArray, isRepeatedCourseArray)

		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_cumulative_hpts_earned = 0
		predicted_cumulative_credits_earned = 0


		[creditsArray, predictedGradeArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isRepeatedCourse|
  		 
  		 		if (isRepeatedCourse)

  		 		else
  					predicted_cumulative_hpts_earned = credits.to_i * gradingSchema[predictedGrade.to_s] + predicted_cumulative_hpts_earned
  					predicted_cumulative_credits_earned = credits.to_i + predicted_cumulative_credits_earned
  				end
  		end
	

		cumulative_hpts = predicted_cumulative_hpts_earned + credits_earned * cumulative_gpa
		all_possible_hpts = (credits_earned + predicted_cumulative_credits_earned) * 4.0

		predicted_cumulative_gpa =  4.0 * (cumulative_hpts / all_possible_hpts)

		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Hpts are  #{predicted_cumulative_hpts_earned}"
		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$predictedGpa is #{predicted_cumulative_gpa}"
		return predicted_cumulative_gpa

	end


	def calculatePredictedMajorGpa(major_credits_earned, major_gpa, creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray)


		gradingSchema = { "A" => 4.0, "AB" => 3.5, "B" => 3.0, "BC" => 2.5, "C" =>2.0, "CD" =>1.5, "D"=> 1.0, "F" => 0.0 }
		predicted_major_hpts_earned = 0
		predicted_major_credits_earned = 0


		[creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isMajorCourse, isRepeatedCourse|
  		
			if (isMajorCourse.to_i == 1) 

				if(isRepeatedCourse)

				else
					logger.debug(key)
  					predicted_major_hpts_earned = credits.to_i * gradingSchema[predictedGrade.to_s] + predicted_major_hpts_earned
  					predicted_major_credits_earned = credits.to_i + predicted_major_credits_earned
  				end
  			end
		end

		cumulative_major_hpts = predicted_major_hpts_earned + major_credits_earned * major_gpa
		all_possible_major_hpts = (major_credits_earned + predicted_major_credits_earned) * 4.0

		predicted_major_gpa =  4.0 * (cumulative_major_hpts / all_possible_major_hpts)

		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Hpts are  #{predicted_major_hpts_earned}"
		logger.debug "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$predictedGpa is #{predicted_major_gpa}"
		return predicted_major_gpa
	
	end


	def getArrayOfParams(parameter, arrayLength)

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
