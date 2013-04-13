module ProjectionsHelper

	#those methods are just mockups for now


	gradingSchema = { A: 4.0, AB: 3.5, B: 3.0, BC: 2.5, C: 2.0, CD: 1.5, D: 1.0, F:0.0 }

	def changeGradingSchema(gradingSchema)

		#change global Grading schema to this global schema
		#how am I gonna change the above grading schema?

	end
	#merge those two methods later

	def calculateGpaNeededForTargetCumulativeGpa(credits_earned, cumulative_gpa, targetGpa, creditsTakenThisSemester) 

		#credits_earned and cumulative_gpa come from student attibutes
		#rest arguments come from form
		gpaNeededForTargetCumulativeGpa = (targetGpa - credits_earned *  cumulative_gpa) / creditsTakenThisSemester
		return gpaNeededForTargetCumulativeGpa;

	end

	def calculateGpaNeededForTargetMajorGpa(credits_earned, major_gpa, targetGpa, majorCreditsTakenThisSemester) 

		#CHANGE CREDITS EARNED TO MAJOR CREDITS EARNED WHEN YOU ADD THIS ATTRIBUTE IN Student table IN SCHEMA

		#credits_earned and cumulative_gpa come from student attibutes
		#rest arguments come from form
		gpaNeededForTargetMajorGpa = (targetGpa - credits_earned * major_gpa) / majorCreditsTakenThisSemester
		return gpaNeededForTargetMajorGpa;

	end




	def calculatePredictedCumulativeGpa(credits_earned, cumulative_gpa, creditsArray, predictedGradeArray, isRepeatedCourseArray)

		#credits_earned and cumulative_gpa are from student attributes, student is found in projections controller @student = Student.find(params[:student_id])
		#the rest of attributes is calculated in projections form

		hpts = 0

		[creditsArray, predictedGradeArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isRepeatedCourse|
   
   			logger.debug "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2"
			logger.debug "Credits are  #{credits}"
			logger.debug "predictedGrade are  #{predictedGrade}"
			logger.debug "Is Repeated course  #{isRepeatedCourse}"
			hpts = hpts + credits.to_i

		end

		#change 0 to htps
		predictedCumulativeGpa = credits_earned * cumulative_gpa + 0
		return predictedCumulativeGpa

	end


	def calculatePredictedMajorGpa(credits_earned, major_gpa, creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray)

		#credits_earned and major_gpa are from student attributes, student is found in projections controller @student = Student.find(params[:student_id])
		#the rest of attributes is calculated in projections form
		hpts = 0

		[creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isMajorCourse, isRepeatedCourse|
  		
  		hpts = hpts + credits.to_i

		end

		#change 0 to htps
		#change to major credits earned
		predictedMajorGpa =  credits_earned * major_gpa + 0
		return predictedMajorGpa
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
