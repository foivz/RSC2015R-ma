class Game < ActiveRecord::Base
  # Types (Capture the flag, elimination)
  self.inheritance_column = nil
  enum type: [:ctf, :elimination]

  before_create :generate_pin

  # Teams
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  # Field
  belongs_to :field

  # Judge
  belongs_to :judge, class_name: 'User', foreign_key: :judge_id

  # Obstacles
  has_many :obstacles

  def current_count
    User.where(game_id: self.id).length
  end

  def total_count
    self.team_a.count + self.team_b.count
  end

protected
  def generate_pin
    begin
      self.pin = (1..PIN_LENGTH).map{PIN_DIGITS.chars.to_a.sample}.join
    end while self.class.exists?(pin: pin, active: true)
  end

private
  PIN_LENGTH = 4
  PIN_DIGITS = '123456789'
end
