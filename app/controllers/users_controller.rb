class UsersController < ApplicationController
  before_filter :signed_user, only: [:edit, :update, :destroy, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  before_filter :set_user, only: [:edit, :update, :destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end
	
  def new
  	@user = User.new
  end

  def show
  	@user = User.find_by(name: params[:name])
    if @user
      @microposts = @user.microposts.paginate(page: params[:page], per_page: 5)
    else
      redirect_to root_path
    end
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      sign_in @user
  		redirect_back_or @user
  	else
  		render :new
  	end
  end

  def destroy
    @user = set_user
    @user.is_active = false

    if @user.save && !current_user.admin?
      sign_out
    end
    redirect_to root_path
  end

  def edit
    @user = set_user
  end

  def update
    @user = set_user
    new_params = user_params
    updated = nil
    password_exist = true

    updated = if params[:user][:password].blank?
      Rails.logger.info 'blank'
      password_exist = false
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      new_params = params.require(:user).permit(:email, :name, :image_base64)
      update_attributes_user(params[:user][:current_password], new_params)
    else
      Rails.logger.info 'no-blank'
      new_params = params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_base64)
      update_attributes_user(params[:user][:current_password], new_params)
    end

    if updated
      # sign_in @user if password_exist
      sign_in @user
      flash[:notice] = "Successfully updated..."
      redirect_back_or @user
    else
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_base64)
  end

  def set_user
    User.find(params[:id])
  end

  def update_attributes_user(password, new_params)
    if @user.check_current_password(password) && @user.update_attributes(new_params)
      true
    else
      flash.now[:alert] = "Cannot saves changed!"
      false
    end
  end

  def signed_user
    unless user_signed_in?
      store_location
      redirect_to login_path, notice: "Please Login!" 
    end
  end

  def correct_user
    redirect_to root_path, notice: "Unallowed!" unless authorize_user?(set_user)
  end

end
