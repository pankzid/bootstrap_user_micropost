module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by(:remember_token => cookies[:remember_token]) if cookies[:remember_token]
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def user_signed_in?
		!current_user.nil?
	end

	def authorize_user?(user)
		(current_user == user) || (current_user.admin? && !is_admin?(user))
	end

	def is_admin?(user)
		user.admin?
	end

	def redirect_back_or(default)
		redirect_to session[:return_to] || default
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.fullpath
	end
end
