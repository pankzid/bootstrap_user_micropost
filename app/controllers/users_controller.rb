class UsersController < ApplicationController
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end
	
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      sign_in @user
  		redirect_to @user, notice: "Welcome to ....."
  	else
  		render :new
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
