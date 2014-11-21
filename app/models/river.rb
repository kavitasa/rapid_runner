class River < ActiveRecord::Base

  has_many :river_states
  has_many :states, through :river_states
  has_many :sections

  validates :name, presence: true
end
