class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true

  validates_uniqueness_of :name

  has_many :wines
end
