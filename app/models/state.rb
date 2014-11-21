class State < ActiveRecord::Base

  has_many :river_states
  has_many :rivers, through :river_states
  has_many :sections

  validates :name, presence: true
  validates_format_of :abbr, with => ^(?:(A[KLRZ]|C[AOT]|D[CE]|FL|GA|HI|I[ADLN]|K[SY]|LA|M[ADEINOST]|N[CDEHJMVY]|O[HKR]|P[AR]|RI|S[CD]|T[NX]|UT|V[AIT]|W[AIVY]))$

end
