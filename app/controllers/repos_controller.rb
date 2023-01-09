class ReposController < ApplicationController
  include FromParams

  before_action :current_user
  before_action :current_repo, only: %i[destroy]

  def index
    @repos = @user.repos
  end

  def poll
    response = Github.user(@user.name).repos[]

    if response[:code].eql?('200')
      Repo.transaction do
        response[:body].pluck('name').each do |repo_name|
          @user.repos.where(name: repo_name).first_or_create!
        end
      end

      redirect_to user_repos_path(@user), notice: 'Repos were polled successfully'
    else
      redirect_to user_repos_path(@user)
    end
  end

  def destroy
    @repo = @user.repos.find(params[:id])
    @repo.destroy

    redirect_to user_repos_path(@user)
  end
end
