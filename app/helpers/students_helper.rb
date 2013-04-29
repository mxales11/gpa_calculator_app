module StudentsHelper

def getStudentGpa(gpa) 

	if(gpa.nil?)
		return 0.0
	else
		return '%.2f' % gpa
	end
end
    
end
