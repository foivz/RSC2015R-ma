class Game < ActiveRecord::Base
  # Types (Capture the flag, elimination)
  self.inheritance_column = nil
  enum type: [:ctf, :elimination]

  before_create :generate_pin
  before_create :set_active

  # Teams
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  # Field
  belongs_to :field

  # Judge
  belongs_to :judge, class_name: 'User', foreign_key: :judge_id

  # Obstacles
  has_many :obstacles

  def joined_count
    User.where(game_id: self.id, role: User.roles[:player]).length
  end

  def alive_count
    User.where(game_id: self.id, alive: true, role: User.roles[:player]).length
  end

  def total_count
    self.team_a.count + self.team_b.counte
  end

  def dead_count
    self.joined_count - self.alive_count
  end

  #Filterable
  include Filterable
  scope :active, -> (active) { where active: active }
  scope :playing, -> (playing) { where playing: playing }

protected
  def generate_pin
    begin
      self.pin = (1..PIN_LENGTH).map{PIN_DIGITS.chars.to_a.sample}.join
    end while self.class.exists?(pin: pin, active: true)
  end

  def set_active
    self.active = true
  end

private
  PIN_LENGTH = 4
  PIN_DIGITS = '123456789'
end
