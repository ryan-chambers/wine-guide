class Wine < ActiveRecord::Base
  # FIXME remove in_cellar, drink_from, drink_until
  attr_accessible :country, :drink_from, :drink_until, :in_cellar, :lcbo_code, :other, :purchased_date,
    :region, :year, :grapes

  validate :year_after_1800

  validates :winery, :year, :country, :grapes, :presence => true

  validates :year, :numericality => true

  belongs_to :winery

  has_many :scores

  has_and_belongs_to_many :grapes

  def year_after_1800
      errors.add(:year, "must be after 1800.") if year < 1800
  end

  def to_s
    [other, grapes_to_s, region, year, lcbo_code, scores.to_s].join(', ')
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

  def real_scores
    scores.select {|score| ! score.in_fridge}
  end

  def cellar_scores
    scores.select {|score| score.in_fridge}
  end
end
