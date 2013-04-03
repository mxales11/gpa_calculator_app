class ProjectionsController < ApplicationController


	def new

	end

	
	def create

		Rails.logger.info("***************************************************************************************")
		Rails.logger.info("PARAMS: #{params.inspect}")
		#it will be  nested route, I need some student attributes
		@projection = Projection.new(params[:projections])
		@projection.gpa_you_want_this_semester = 4.0;	
	end

	def destroy

	end
end
