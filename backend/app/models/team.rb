class Team < ActiveRecord::Base
  # Players
  has_many :users

  # Team messages
  has_many :team_messages

  def joined_count
    User.where(team_id: self.id, role: User.roles[:player]).length
  end

  def alive_count
    User.where(team_id: self.id, alive: true, role: User.roles[:player]).length
  end

  def total_count
    self.count
  end

  def dead_count
    self.joined_count - self.alive_count
  end
end
