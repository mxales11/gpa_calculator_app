
module TakenCoursesHelper

	def taken_courses_list_item(taken_course)
		out ="<div id=" + index_row_div_id(@taken_course) + ">"
		out+="<li><b>" + taken_course.name + getProperIndentation(taken_course.name, 15) + "</b>"
		out+=taken_course.grade.to_s + getProperIndentation(taken_course.grade.to_s, 7)
		out+=taken_course.credits.to_s + getProperIndentation(taken_course.credits.to_s, 4)
		out+=link_to('Delete', student_taken_course_path(@student, taken_course), :class => "small-link", confirm: 'Are you sure?', method: :delete, :remote => true)
		out+="</li></div>"
		out.html_safe
	end


	def taken_courses_list(taken_courses)
		out = "<ul id='taken_courses_list' class='unstyled' 
			style='font-size:8pt;padding:10px'>"
		out += "<li><h4>Your completed courses</h4></li>"
		out += "<br/><li>"+  "<h5>Name" + getProperIndentation("Name", 15) + "Grade" +  getProperIndentation("Grade", 7) + "Credits" + "</h5>" + "</li>"
	   	
	   	taken_courses.each { |c|
	   		out += taken_courses_list_item(c)
	   	 }
	   	 out += "</ul>"
	   	 out.html_safe

	   end


	def getProperIndentation(string, max) 

		spaces = max - string.length
		out = "&nbsp" * spaces + ";"
		out.html_safe


	end

	def index_row_div_id(model)
		"#{model.class.to_s.downcase}_#{model.id}"
	end

end