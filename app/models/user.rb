class User < ApplicationRecord
  has_many :repos
  has_many :pull_requests
end
