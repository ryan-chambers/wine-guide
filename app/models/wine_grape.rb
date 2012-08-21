class WineGrape < ActiveRecord::Base
  attr_accessible :grape, :wine

  belongs_to :wine
end
