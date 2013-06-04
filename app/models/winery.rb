class Winery < ActiveRecord::Base
  attr_accessible :name, :wines

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  has_many :wines

  before_save { |winery| winery.name = winery.name.split(/(\W)/).map(&:capitalize).join }

  def self.find_by_name(name)
    if(name)
      where("lower(name) = ?", name.downcase).first
    else
      nil
    end  
  end

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
