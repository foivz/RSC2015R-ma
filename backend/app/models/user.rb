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

private
  def set_active
    self.active = true
  end
end
