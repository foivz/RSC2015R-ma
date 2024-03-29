class User < ActiveRecord::Base
  # Authenticatable
  include Authenticatable

  # Roleable
  enum role: [:spectator, :player, :judge, :admin]

  # Closable
  before_create :set_active
  def inactive?
    !active?
  end

  # Filterable
  include Filterable
  scope :active, -> (active) { where active: active }
  scope :role, -> (role) { where role: User.roles[role.to_sym] }
  scope :query, -> (query) { where('name ILIKE ?', "%#{query}%") }

  # Validations
  validates_inclusion_of :active, in: [true, false], if: :active
  validates_presence_of :role

  # Player
  belongs_to :game
  belongs_to :team

  # Individual messages
  has_many :received_individual_messages, class_name: 'IndividualMessage', foreign_key: 'recipient_id'
  has_many :sent_individual_messages, class_name: 'IndividualMessage', foreign_key: 'sender_id'

  # Team messages
  has_many :team_messages

  # Statistics
  has_many :user_statistics

  def has_statistics
    self.user_statistics.exists?
  end

  def min_duration
    self.user_statistics.minimum(:duration_alive)
  end

  def max_duration
    self.user_statistics.maximum(:duration_alive)
  end

  def avg_duration
    self.user_statistics.average(:duration_alive)
  end

  def death_count
    self.user_statistics.where(died: true).length
  end

  def win_count
    self.user_statistics.where(won: true).length
  end

  def loss_count
    self.user_statistics.where(won: false).length
  end

private
  def set_active
    self.active = true
  end
end
