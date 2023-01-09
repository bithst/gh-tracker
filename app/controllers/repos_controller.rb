class ReposController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @repos = @user.repos
  end

  def new
    @user = User.find(params[:user_id])
    @repo = Repo.new
  end

  def create
    @user = User.find(params[:user_id])
    @repo = Repo.new(repo_params)
    @repo.user = @user

    if @repo.save
      redirect_to user_repos_path(@user)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @repo = @user.repos.find(params[:id])
    @repo.destroy

    redirect_to user_repos_path(@user)
  end

  private

  def repo_params
    params.require(:repo).permit(:name)
  end
end
