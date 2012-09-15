class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  has_many :wines
end
