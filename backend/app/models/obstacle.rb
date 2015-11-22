class Obstacle < ActiveRecord::Base
  # Type
  self.inheritance_column = nil
  enum type: [:flag, :obstacle]

  belongs_to :game

  before_create :generate_pin

protected
  def generate_pin
    self.pin = (1..PIN_LENGTH).map{PIN_DIGITS.chars.to_a.sample}.join
  end

private
  PIN_LENGTH = 8
  PIN_DIGITS = '123456789'
end
