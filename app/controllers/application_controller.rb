class ApplicationController < ActionController::Base
  $:.unshift("../lib")
  protect_from_forgery
  include SessionsHelper

end
