class ContributorsController < ApplicationController
  include FromParams

  before_action :current_user
  before_action :current_repo

  def index
    @contributors = @repo.contributors
  end

  def poll
    response = Github.user(@user.name).repos(@repo.name).contributors[]

    if response[:code].eql?('200')
      Contributor.transaction do
        response[:body].pluck('login').each do |contributor_name|
          @repo.contributors.where(name: contributor_name).first_or_create!
        end
      end

      redirect_to user_repo_contributors_path(@user, @repo), notice: 'Repos were polled successfully'
    else
      redirect_to user_repo_contributors_path(@user, @repo)
    end
  end
end
