class Score < ActiveRecord::Base
  belongs_to :wine
  attr_accessible :comments, :price, :reviewdate, :score
end
