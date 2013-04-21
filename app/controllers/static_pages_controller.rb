class StaticPagesController < ApplicationController
  def home
  	@student = current_student
  	if signed_in?
  		redirect_to @student
  	end
  end

  def help
  	@student = current_student
  end

  def about
  	@student = current_student
  end
end
