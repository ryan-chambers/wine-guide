class Grape < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true

  validates_uniqueness_of :name

  has_and_belongs_to_many :wines

  def self.is_grape?(grape)
    not where(:name => grape).empty?
  end
end
