module StudentsHelper

    def getStudentGpa(gpa) 

    	if(gpa.nil?)
    		return 0.0
    	else
    		return '%.2f' % gpa
    	end
    end


    def displayHeader()
        
    	if current_user.nil?
            out ="Sign Up"
        else
        	out="Edit Account Information"
        end   
        out.html_safe
    end



    def getButtonDisplay()

        if current_user.nil?
            out ="Create my account"
        else
            out="Save"
        end   
        out.html_safe
    end
end


