
module TakenCoursesHelper

	def taken_courses_list_item(taken_course)
		out = "<tr id='" + index_row_div_id(@taken_course) + "'><td><b>" + taken_course.name + "</b></td>"
		out+= "<td>" + taken_course.grade.to_s +  "</td>"
		out+= "<td>" + taken_course.credits.to_s + "</td>"
		out+= "<td>" + link_to('Delete', student_taken_course_path(@student, taken_course), :class => "small-link", confirm: 'Are you sure?', method: :delete, :remote => true) + "</td>"
		out+="</tr>"
		out.html_safe
	end


	def taken_courses_list(taken_courses)
		out = "<h4>Your completed courses</h4><table class='unstyled' 
			style='font-size:8pt;padding:10px'><tbody id='taken_courses_list'><tr><th>Name</th><th>Grade</th><th>Credits</th><th></th></tr>"
	   	
	   	taken_courses.each { |c|
	   		out += taken_courses_list_item(c)
	   	 }
	   	 out += "</tbody></table>"
	   	 out.html_safe

	   end


	def index_row_div_id(model)
		"#{model.class.to_s.downcase}_#{model.id}"
	end

end