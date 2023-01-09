# frozen_string_literal: true

module Github
  class User
    attr_reader :user_name

    def initialize(user_name)
      @user_name = user_name || @user_name
    end

    def path
      [BASE_URL, 'users'].join('/')
    end

    def repos(repository = nil)
      Github::Repos.new(@user_name, repository)
    end
  end
end
