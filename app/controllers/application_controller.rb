class ApplicationController < ActionController::Base
  $:.unshift("../lib")
  protect_from_forgery
  include SessionsHelper
  require "projector.rb"

  rescue_from CanCan::AccessDenied do |exception|
  	if signed_in?
      @student = current_user
      flash[:notice] = "You are not authorized to use this functionality"
  		redirect_to @student
  	
  	else
      flash[:notice] = "Please sign in to use this application"
  		redirect_to signin_path
  	end
  end

end
