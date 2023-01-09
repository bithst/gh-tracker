class ContributorsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @repo = @user.repos.find(params[:repo_id])

    @contributors = @repo.contributors
  end
end
