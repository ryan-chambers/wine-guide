class Grape < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true

  validates_uniqueness_of :name

  has_and_belongs_to_many :wines

  def self.search_by_name(name)
    if(name)
      like = "%".concat(name.downcase.concat("%"))
      where("lower(name) like ?", like).order('name asc')
    else
      scoped
    end
  end

  def to_s
    name
  end
end
