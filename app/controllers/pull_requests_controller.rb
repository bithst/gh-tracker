class PullRequestsController < ApplicationController
  include FromParams

  before_action :current_user
  before_action :current_repo

  def index
    @pull_requests = @repo.pull_requests
  end

  def poll
    response = Github.user(@user.name).repos(@repo.name).pull_requests[]

    if response[:code].eql?('200')
      Contributor.transaction do
        response[:body].each do |pull_request|
          @repo.pull_requests.where(title: pull_request['title'], state: pull_request['state'], user: @user).first_or_create!
        end
      end

      redirect_to user_repo_pull_requests_path(@user, @repo), notice: 'Repos were polled successfully'
    else
      redirect_to user_repo_pull_requests_path(@user, @repo)
    end
  end
end
