class StaticPagesController < ApplicationController
	def home
		@microposts = current_user.microposts.paginate(page: params[:page], per_page: 10) if user_signed_in?
		@micropost = Micropost.new
	end
end