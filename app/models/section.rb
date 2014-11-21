class Section < ActiveRecord::Base
  
  belongs_to :river
  belongs_to :state

  validates :name, presence: true
  validates :water_class, presence: true
  validates :takeout_long, presence: true, numericality: true
  validates :takeout_lat, presence: true, numericality: true
  validates :putin_long, presence: true, numericality: true
  validates :putin_lat, presence: true, numericality: true
end
