class Wine < ActiveRecord::Base
  validate :year_after_1800

  validates :winery_id, :year, :country, :grapes, :presence => true

  validates :year, :numericality => true

  belongs_to :winery

  has_many :bottles

  has_and_belongs_to_many :grapes

  def self.filter_paginate(grape_filter, page)
    if(grape_filter)
      find_by_grapes(grape_filter).paginate(page)
    else
      Wine.joins(:winery).includes(:grapes, :winery).paginate(page).order('wineries.name asc')
    end
  end

  def self.find_by_grapes(grapes)
    like = "%".concat(grapes.downcase.concat("%"))
    Wine.joins(:grapes).includes(:grapes, :winery).where("lower(grapes.name) like ?", like)
  end

  def self.find_favourites(score_filter)
    logger.info "Filtering for favourites scored #{score_filter} and higher"
    score = score_filter || 90
    Wine.joins(:bottles).includes(:grapes, :bottles, :winery).where('bottles.score >= :score', {:score => score}).uniq
  end

  def self.find_all_by_lcbo_code(lcbo_code)
    Wine.where(lcbo_code: lcbo_code)
  end

  def self.find_in_cellar
    Wine.joins(:bottles).includes(:grapes, :bottles, :winery).where(:bottles => {:in_fridge => true}).order('bottles.drink_from')
  end

  def self.find_in_cellar_ready_to_drink
    from = Time.new.strftime('%Y').to_i
    Wine.joins(:bottles).includes(:grapes, :bottles, :winery).where('(bottles.drink_from is null or bottles.drink_from <= ?) and bottles.in_fridge = ?', from, true).order('bottles.drink_from')
  end

  def self.find_drank_this_day
    Wine.joins(:bottles).where(:bottles => {:in_fridge => false, :review_day_of_year => day_of_year}).order('bottles.reviewdate')
  end

  def self.find_by_winery_name(winery_name)
    p "searching wine by winery name #{winery_name}"
    limit = 100
    if winery_name.empty?
      limit = 5
    end
    like = "%".concat(winery_name.downcase.concat("%"))
    Wine.joins(:winery, :grapes).includes(:winery, :grapes).where("lower(wineries.name) like ?", like).limit(limit)
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
    [other, grapes_to_s, region, year, lcbo_code, grapes.to_s, bottles.to_s].join(', ')
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

  def grapes_to_s(separator=", ")
    grapes.empty? ? '' : grapes.join(separator)
  end

  def drunk_bottles
    bottles.select {|bottle| ! bottle.in_fridge}
  end

  def cellar_bottles
    bottles.select {|bottle| bottle.in_fridge}
  end

  def favourite_bottles
    bottles.select {|bottle| bottle.score >= 90 }
  end

  def drank_this_day_bottles
    bottles.select { |bottle|
#      p "#{bottle.review_day_of_year}"
      # FIXME why can't i access using attr?
      bottle[:review_day_of_year] == Wine::day_of_year
    }
  end

  private

  def year_after_1800
      errors.add(:year, "must be after 1800.") if ! year.nil? and year < 1800
  end

  def self.day_of_year 
    d = Time.new
    d.day.to_s.concat(' ').concat(d.month.to_s)
  end
end
