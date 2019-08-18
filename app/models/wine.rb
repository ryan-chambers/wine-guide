class Wine < ActiveRecord::Base
  validate :year_after_1800

  validates :winery_id, :year, :country, :grapes, :presence => true

  validates :year, :numericality => true

  belongs_to :winery

  has_many :bottles

  has_and_belongs_to_many :grapes

  def self.find_all_by_lcbo_code(lcbo_code)
    Wine.where(lcbo_code: lcbo_code)
  end

  def self.find_in_cellar
    Wine.joins(:bottles).includes(:grapes, :bottles, :winery, :wines_grapes).where(:bottles => {:in_fridge => true}).order('bottles.drink_from')
  end

  def self.find_in_cellar_ready_to_drink
    from = Time.new.strftime('%Y').to_i
    Wine.joins(:bottles).includes(:grapes, :bottles, :winery, :wines_grapes).where('(bottles.drink_from is null or bottles.drink_from <= ?) and bottles.in_fridge = ?', from, true).order('bottles.drink_from')
  end

  def self.find_drank_this_day
    Wine.joins(:bottles).includes(:bottles, :grapes, :wines_grapes, :winery).where(:bottles => {:in_fridge => false, :review_day_of_year => day_of_year}).order('bottles.reviewdate')
  end

  def self.search_for_wine(search_term, review_from, review_to)
    if review_from.empty? and review_to.empty?
      results = Wine.joins(:winery, :grapes)
    else
      results = Wine.joins(:winery, :grapes, :bottles)
    end
    results = results.includes(:winery, :grapes, :wines_grapes)

    limit = 5

    if ! search_term.empty?
#      p "Searching for winery/other/region #{search_term}"
      like = "%".concat(search_term.downcase.concat("%"))
      results = results.where("lower(wineries.name) like ? or lower(wines.other) like ? or lower(wines.region) like ?", like, like, like)
      limit = 100      
    end

    if ! review_from.empty?
#      p "searching after #{review_from}"
      results = results.where("bottles.reviewdate >= ?", Date.parse(review_from))
      limit = 100
    end

    if ! review_to.empty?
#      p "searching before #{review_to}"
      results = results.where("bottles.reviewdate <= ?", Date.parse(review_to))
#      p "#{results.arel.to_sql}"
      limit = 100
    end

    results = results.limit(limit)

    results
  end

  def self.filter_by_grapes_country(grapes, country)
    logger.info "Filtering by grapes #{grapes}, country #{country}"
    if ! grapes.empty?
      grapes_like = "%".concat(grapes.downcase.concat("%"))
      results = Wine.joins(:grapes).includes(:grapes, :winery, :wines_grapes).where("lower(grapes.name) like ?", grapes_like)
    else
      results = Wine.includes(:grapes, :winery)
    end

    if ! country.empty?
      results = results.where(:wines => {:country => country})
    end

    results
  end

  def self.filter_paginate(grape_filter, country_filter, page)
    if(grape_filter || country_filter)
      filter_by_grapes_country(grape_filter, country_filter).paginate(page)
    else
      Wine.joins(:winery).includes(:grapes, :winery).paginate(page).order('wineries.name asc')
    end
  end

  def self.find_favourites(score_filter, date=Date.new(2009, 1, 1))
    # p "Filtering for favourites scored #{score_filter} and higher from #{date} and after"
    score = score_filter || 90
    Wine.joins(:bottles)
      .includes(:grapes, :bottles, :winery, :wines_grapes)
      .where('bottles.score >= :score and bottles.reviewdate >= :date', {:score => score, :date => date})
      .distinct
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
    if grapes.empty?
      ''
    else
      grape_names = grapes.reduce([]) { |out, g|
#        p "Adding #{g.name} to #{out}"
        out << g.name
      }
      grape_names.join(separator)
    end
  end

  def drunk_bottles
    dbs = bottles.select {|bottle| ! bottle.in_fridge}
    dbs.sort_by { |b| b.reviewdate }
    dbs.reverse!
  end

  def cellar_bottles
    bottles.select {|bottle| bottle.in_fridge}
  end

  def favourite_bottles
    bottles.select {|bottle| bottle.score >= 88 }
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
