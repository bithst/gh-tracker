class Repo < ApplicationRecord
  belongs_to :user
  has_many :contributors
  has_many :pull_requests
end
