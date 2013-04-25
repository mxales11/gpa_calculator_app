class StaticPagesController < ApplicationController
  def home
  	@student = current_user
  	if signed_in?
  		redirect_to @student
  	end
  end

  def help
  	@student = current_user
  end

  def about
  	@student = current_user
  end
end
