class Projector


	def self.changeGradingSchema(gradingSchema)

		#change global Grading schema to this global schema
		#how am I gonna change the above grading schema?

	end
	#merge those two methods later

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