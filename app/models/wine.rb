class Wine < ActiveRecord::Base
  attr_accessible :country,  :lcbo_code, :other, :purchased_date, :region, :year, :grapes

  validate :year_after_1800

  validates :winery_id, :year, :country, :grapes, :presence => true

  validates :year, :numericality => true

  belongs_to :winery

  has_many :bottles

  has_and_belongs_to_many :grapes

  def self.find_wines_in_cellar
    Wine.joins(:bottles).where(:bottles => {:in_fridge => true})
  end

  def self.find_by_winery_year_lcbo_code(winery_id, year, lcbo_code)
    # p "Searching for lcbo code '#{lcbo_code}'"
    if winery_id and year and ! lcbo_code.empty?
      Wine.where(:lcbo_code => lcbo_code, :year => year, :winery_id => winery_id)
    else
      []
    end
  end

  def to_s
    [other, grapes_to_s, region, year, lcbo_code, bottles.to_s].join(', ')
  end

  def list_grape_names
    i = 0
    grape_names = []
    until i >= grapes.length
      grape_names << grapes[i].name
      i += 1
    end
    grape_names.sort!
  end

  def grapes_to_s
    grapes.empty? ? '' : grapes.join(', ')
  end

  def drunk_bottles
    bottles.select {|bottle| ! bottle.in_fridge}
  end

  def cellar_bottles
    bottles.select {|bottle| bottle.in_fridge}
  end

  private
  
  def year_after_1800
      errors.add(:year, "must be after 1800.") if ! year.nil? and year < 1800
  end
end
