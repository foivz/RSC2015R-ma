class Team < ActiveRecord::Base
  # Players
  has_many :users

  # Team messages
  has_many :team_messages
end
