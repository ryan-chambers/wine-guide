class Grape < ActiveRecord::Base
#  attr_accessible :name, :wines

  validates :name, :presence => true

  validates_uniqueness_of :name

  has_and_belongs_to_many :wines

  before_save { |grape| grape.name = grape.name.split(/(\W)/).map(&:capitalize).join }

  def self.search_by_name(name)
    if(name)
      like = "%".concat(name.downcase.concat("%"))
      where("lower(name) like ?", like).order('name asc')
    else
      Grape.findAll
    end
  end

  def self.findAll
    self.order('name asc')
  end

  def to_s
    name
  end
end
