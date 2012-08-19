class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true

  has_many :wines
end
