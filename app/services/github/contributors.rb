# frozen_string_literal: true

module Github
  class Contributors
    def initialize(user_name, repository)
      @user_name = user_name
      @repository = repository
    end

    def path
      [BASE_URL, 'repos', @user_name, @repository, 'contributors'].join('/')
    end

    def [](_index = nil)
      Req.get(path)
    end
  end
end
