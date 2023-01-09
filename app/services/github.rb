# frozen_string_literal: true

module Github
  BASE_URL = 'https://api.github.com'

  def self.user(user_name)
    Github::User.new(user_name)
  end
end
