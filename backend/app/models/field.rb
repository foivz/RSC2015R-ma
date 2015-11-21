class Field < ActiveRecord::Base
  # Filterable
  include Filterable
  scope :occupied, -> (occupied) { where occupied: occupied }

  before_create :set_not_occupied

private
  def set_not_occupied
    self.occupied = false
  end
end
