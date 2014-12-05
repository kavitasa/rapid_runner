class River < ActiveRecord::Base
  has_and_belongs_to_many :states
  has_many :sections

  validates :name, presence: true
end
