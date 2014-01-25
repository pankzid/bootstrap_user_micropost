class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :authorize_user?
  	
	def authorize_user?(user)
		(current_user == user) || (current_user.admin? && !user.admin?)
	end
end
