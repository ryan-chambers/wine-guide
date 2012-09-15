class Grape < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true

  validates_uniqueness_of :name

  has_and_belongs_to_many :wines

  def to_s
    name
  end
end
