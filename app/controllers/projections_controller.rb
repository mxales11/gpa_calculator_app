class ProjectionsController < ApplicationController


	def new

     
  	end
	
	def create

		Rails.logger.info("***************************************************************************************")
		Rails.logger.info("PARAMS: #{params.inspect}")
		render 'new'
		
	end

	def destroy

	end


end
