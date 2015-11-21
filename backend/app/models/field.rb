class Field < ActiveRecord::Base
  # Filterable
  include Filterable
  scope :occupied, -> (occupied) { where occupied: occupied }
end
