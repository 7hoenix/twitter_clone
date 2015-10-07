class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Nucleus!"
      redirect_to @user
    else
      flash[:error] = "Invalid email/password combination"
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "You have updated your profile"
      redirect_to @user
    else
      flash[:error] = "Invalid email/password combination"
      render "edit"
    end
  end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end
end
