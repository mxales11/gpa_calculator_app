module SessionsHelper



def sign_in(student)
	cookies.permanent[:remember_token] = student.remember_token
	self.current_user = student
end

def signed_in?
	!current_user.nil?
end

def current_user=(student)
	@current_user = student
end

def current_user
	@current_user ||= Student.find_by_remember_token(cookies[:remember_token])
end

def current_user?(student)
	student == current_user
end

def sign_out
	self.current_user = nil
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


