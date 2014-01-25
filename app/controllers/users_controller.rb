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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    new_params = user_params
    updated = nil
    password_exist = true

    updated = if params[:user][:password].blank?
      Rails.logger.info 'blank'
      password_exist = false
      @user.password_validation(false)
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      new_params = params.require(:user).permit(:email, :name, :image_base64)
      @user.valid_user?(params[:user][:current_password])
      if @user.check_current_password(params[:user][:current_password])
        @user.update_attributes(new_params)
      else
        flash.now[:alert] = "Please fill current_password"
        render :edit
      end      
    else
      Rails.logger.info 'no-blank'
      @user.password_validation(true)
      new_params = params.require(:user).permit(:name, :email, :current_password, :password, :password_confirmation, :image_base64)
      if @user.check_current_password(params[:user][:current_password])
        @user.update_attributes(new_params)
      else
        flash.now[:alert] = "Please fill current_password"
        render :edit
      end
    end

    Rails.logger.info updated

    if updated
      if password_exist
        sign_in @user, bypass: true
      end
      redirect_to @user, notice: 'Updated successfully'
    else
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_base64)
  end

end
