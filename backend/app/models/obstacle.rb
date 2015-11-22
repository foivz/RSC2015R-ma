class Obstacle < ActiveRecord::Base
  # Type
  self.inheritance_column = nil
  enum type: [:flag, :obstacle]

  belongs_to :game
end
