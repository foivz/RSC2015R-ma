class Obstacle < ActiveRecord::Base
  # Type
  self.inheritance_column = nil
  enum type: [:flag, :house, :tower, :wall, :trench]

  belongs_to :game
end