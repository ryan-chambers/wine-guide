class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  has_many :wines

  def self.find_by_name(name)
    where("lower(name) = ?", name.downcase).first
  end

  def self.search_by_name(name)
    if(name)
      like= "%".concat(name.downcase.concat("%"))
      where("name like ?", like).order('name asc')
    else
      scoped
    end
  end

  def to_s
    name
  end
end
