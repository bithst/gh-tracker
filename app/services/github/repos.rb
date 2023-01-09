# frozen_string_literal: true

module Github
  class Repos
    def initialize(user_name, repository = nil)
      @user_name = user_name
      @repository = repository

      @user = Github::User.new(user_name)
    end

    def path
      [BASE_URL, 'users', @user_name, 'repos'].join('/')
    end

    def [](_index = nil)
      Req.get(path)
    end

    def contributors
      Github::Contributors.new(@user_name, @repository)
    end

    def pull_requests
      Github::PullRequests.new(@user_name, @repository)
    end
  end
end
