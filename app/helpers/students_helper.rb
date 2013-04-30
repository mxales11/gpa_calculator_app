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


    def displayErrors(student)

    	if @student.errors.any?
            out= "<div id='error_explanation'>
                <h2><%= pluralize(student.errors.count, 'error') %> prohibited this student from being saved:</h2>
                <ul>
                <% student.errors.full_messages.each do |msg| %>
                  <li><%= msg %></li>
                <% end %>
                </ul>
              </div>
            <% end %>"
        end

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


