class UsersController < ApplicationController
  include FromParams

  before_action :current_user, only: %i[destroy]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path
  end

  private

  def user_params
    params.permit(:name)
  end
end
