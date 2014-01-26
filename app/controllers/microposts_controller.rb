class MicropostsController < ApplicationController
	before_filter :signed_in?, only:[:edit, :create, :update, :destroy]
	before_filter :correct_user, only: [:edit, :update, :destroy]

	def index
		
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)

		if @micropost.save
			redirect_to current_user, notice: "Micropost successfully created"
		else
			render 'static_pages/home'
		end
	end

	def edit
		@micropost = set_micropost
	end

	def update
		@micropost = set_micropost

		if @micropost.update_attributes(micropost_params)
			redirect_to current_user, notice: "micropost update successfully"
		else
			render :edit
		end
	end

	def destroy
		@micropost.destroy
		redirect_to current_user, notice: "Micropost deleted"
	end

	private
	def micropost_params
		params.require(:micropost).permit(:content)
	end

	def set_micropost
		current_user.microposts.find(params[:id])
	end

	def signed_in?
		unless user_signed_in?
			store_location
			redirect_to login_path, notice: "Please login!"
		end
	end

	def correct_user
		@micropost =  set_micropost
		redirect_to root_path if @micropost.nil?
	end
end