class ProjectionsController < ApplicationController


	def new 
		#or better just take current student
		@student = Student.find(params[:student_id])


     
  	end
	
	def create

		@student = Student.find(params[:student_id])
		Rails.logger.info("***************************************************************************************")
		Rails.logger.info("PARAMS: #{params.inspect}")
		render 'new'
		
	end

	def destroy

	end


end
