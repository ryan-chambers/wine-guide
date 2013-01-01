class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  has_many :wines

  def self.find_by_name(name)
    Winery.where("lower(name) = ?", name.downcase).first
  end

  def to_s
    name
  end
end
