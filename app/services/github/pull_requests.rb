# frozen_string_literal: true

module Github
  class PullRequests
    def initialize(user_name, repository)
      @user_name = user_name
      @repository = repository
    end

    def path
      [BASE_URL, 'repos', @user_name, @repository, 'pulls'].join('/')
    end

    def [](_index = nil)
      Req.get(path)
    end
  end
end
