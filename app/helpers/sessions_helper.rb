module SessionsHelper



def sign_in(student)
	cookies.permanent[:remember_token] = student.remember_token
	self.current_student = student
end

def signed_in?
	!current_student.nil?
end

def current_student=(student)
	@current_student = student
end

def current_student
	@current_student ||= Student.find_by_remember_token(cookies[:remember_token])
end

def current_user?(student)
	student == current_student
end

def sign_out
	self.current_student = nil
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


