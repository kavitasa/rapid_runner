class RiverState < ActiveRecord::Base
  belongs_to :river
  belongs_to :state
  validates :river, presence: true
  validates :state, presence: true
end
