# frozen_string_literal: true

module FromParams
  extend ActiveSupport::Concern

  def current_user
    @user = User.find(params[:user_id])
  end

  def current_repo
    current_user
    @repo = @user.repos.find(params[:repo_id])
  end
end
