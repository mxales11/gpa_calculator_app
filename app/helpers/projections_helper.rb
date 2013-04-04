module ProjectionsHelper


	gradingSchema = { A: 4.0, AB: 3.5, B: 3.0, BC: 2.5, C: 2.0, CD: 1.5, D: 1.0, F:0.0 }

	#those methods are just mockups for now

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

		hpts = 0;

		[creditsArray, predictedGradeArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isRepeatedCourse|
  # . . 
			puts credits
			puts predictedGrade
			puts isRepeatedCourse
			hpts = hpts + credits * predictedGrade

		end

		predictedCumulativeGpa = creditsEarned * cumulative_gpa + htps
		return predictedCumulativeGpa

	end


	def calculatePredictedMajorGPA(credits_earned, major_gpa, creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourse)

		#credits_earned and major_gpa are from student attributes, student is found in projections controller @student = Student.find(params[:student_id])
		#the rest of attributes is calculated in projections form
		hpts = 0;

		[creditsArray, predictedGradeArray, isMajorCourseArray, isRepeatedCourseArray].transpose.each do |credits, predictedGrade, isMajorCourse, isRepeatedCourse|
  # . . 
			puts credits
			puts predictedGrade
			puts isMajorCourse
			puts isRepeatedCourse
			hpts = hpts + credits * predictedGrade

		end
		predictedMajorGpa = creditsEarned * major_gpa + htps
		return predictedMajorGpa
	end




end
