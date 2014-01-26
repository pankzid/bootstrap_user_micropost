class StaticPagesController < ApplicationController
	def home
		if user_signed_in?
			@microposts = current_user.microposts.paginate(page: params[:page], per_page: 10)
			@micropost = Micropost.new
		end
	end
end