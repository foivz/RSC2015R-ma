class Team < ActiveRecord::Base
  # Players
  has_many :users

  # Team messages
  has_many :team_messages

  def joined_count
    User.where(team_id: self.id).length
  end

  def alive_count
    User.where(team_id: self.id, alive: true).length
  end

  def total_count
    self.count
  end
end
