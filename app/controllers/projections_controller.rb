class ProjectionsController < ApplicationController


	def new

     
  	end
	
	def create

		Rails.logger.info("***************************************************************************************")
		Rails.logger.info("PARAMS: #{params.inspect}")

		#use update attributes for that
		#@projection.gpa_you_want_this_semester = 4.0;	
		render 'new'
		
	end

	def destroy

	end

	def show

	end


end
