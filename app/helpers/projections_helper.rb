module ProjectionsHelper


	def calculateGPANeededForTargetGPA(desiredGPA, creditsTakenThisSemester, earnedCredits, currentGPA) 

		gpaNeededForTargetGPA = (desiredGPA - earnedCredits *  currentGPA) / creditsTakenThisSemester
		return gpaNeededForTargetGPA;

	end



end
