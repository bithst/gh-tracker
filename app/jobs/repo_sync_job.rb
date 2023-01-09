# frozen_string_literal: true

# Fetches the repositories of all the users
class RepoSyncJob < ApplicationJob
  queue_as :notification

  def perform
    users = User.all

    User.transaction do
      users.each do |user|
        repos = Github.user(user.name).repos[]

        repos.each do |repo_name|
          user.repos.where(name: repo_name).first_or_create!
        end
      end
    end
  end
end
