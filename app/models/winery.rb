class Winery < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  has_many :wines

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
      limit(20).order('name asc')
    end
  end

  def to_s
    name
  end
end
