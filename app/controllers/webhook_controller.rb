class WebhooksController < ApplicationController
  def github
    @user = User.find_by(name: github_params[:sender])
    @repo = @user.repos.find_by(name: github_params[:repository])

    @repo.pull_requests.create!(status: github_params[:action], title: github_params[:pull_request][:title], user: @user)
  end

  private

  def github_params
    params.require(:pull_request).permit(:action, :sender, :repository, pull_request: [:title])
  end
end
