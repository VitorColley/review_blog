class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Account created!"
    else
      Rails.logger.debug(@user.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :password_confirmation, :bio)
  end
end