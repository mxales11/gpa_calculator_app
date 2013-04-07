module SessionsHelper

	def sign_in(student)
		cookies.permanent[:remember_token] = student.remember_token
		self.current_student = student
	end


	def signed_in?
		if(!current_student.nil?) 
			Rails.logger.info("current_student is signed in")
		else
			Rails.logger.info("current_student is NOT signed in")
		end
	end


	def signed_in_student
		unless signed_in?
			store_location
			redirect_to signin_path, notice: "Please sign in."
		end
	end


	def current_student=(student)
		@current_student = student
		Rails.logger.info("Current student assignment was invoked current student is")
		Rails.logger.info(@current_student)

	end

	def current_student
		@current_student ||= Student.find_by_remember_token(cookies[:remember_token])
	end

	def current_student?(student)
		student == current_student
	end

	def sign_out
		Rails.logger.info("SIGN OUT WAS INVOKED")
		self.current_student = nil
		Rails.logger.info("Current student is")
		Rails.logger.info(self.current_student)
		cookies.delete(:remember_token)
	end


	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end
end