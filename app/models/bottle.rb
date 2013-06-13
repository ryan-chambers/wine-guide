class Bottle < ActiveRecord::Base
  attr_accessible :reviewdate, :score, :comments, :price, :wine, :drink_to, :drink_from, :in_fridge, :bought
  attr_reader :review_day_of_year

  validate :score_between_0_and_100, :score_not_null_unless_in_fridge, :comments_not_null_unless_in_fridge, :reviewdate_not_null_unless_in_fridge

  validates :price, :presence => true

  belongs_to :wine

  after_initialize :init

  def init
    in_fridge ||= false
  end

  def reviewdate=(reviewdate)
    self[:reviewdate] = reviewdate
    if ! reviewdate.nil? and ! reviewdate.empty?
      d = Date.parse reviewdate
      self[:review_day_of_year] = d.day.to_s.concat(' ').concat(d.month.to_s)
#      p "Set review day of year to #{review_day_of_year} from #{reviewdate}"
    end
  end

  def self.generate_country_report
    Bottle.find_by_sql("select wines.country, avg(bottles.score) as avg_score, avg(bottles.price) as avg_price, count(bottles.id) as count
      from wines wines, bottles bottles
      where wines.id = bottles.wine_id
      and (bottles.in_fridge is null or bottles.in_fridge = 'f')
      group by wines.country
      order by wines.country").collect { |r|
        CountryReportVO.new :country => r[:country], :avg_score => Float(r[:avg_score]), :total_bottles => Integer(r[:count]), :avg_price => Float(r[:avg_price])
      }
  end

  def score_not_null_unless_in_fridge
    errors.add(:score, "is missing.") if score.nil? and ! in_fridge
  end

  def comments_not_null_unless_in_fridge
#    logger.debug "comments '#{comments}' and in_fridge #{in_fridge}"
    errors.add(:comments, "are missing.") if (comments.nil? || comments.empty?) and ! in_fridge
  end

  def reviewdate_not_null_unless_in_fridge
    errors.add(:reviewdate, "is missing.") if :reviewdate.nil? and ! in_fridge
  end

  def score_between_0_and_100
    errors.add(:score, "must be between 0 and 100.") if score.nil? || score > 100 || score < 0
  end

  def wine_price
    if price.nil?
      '$ unknown'
    else
      '$%.2f' % price
    end
  end

  def wine_score
    if score.nil?
      '?'
    else
      score.ceil.to_s
    end
  end

  def wine_reviewdate
    if reviewdate.nil?
      nil
    else
      reviewdate.strftime('%d %b %Y')
    end
  end

  def to_s
    [comments, score, reviewdate, price, drink_to, drink_from, in_fridge, (bought unless bought.nil?)].join(', ')
  end
end

class CountryReportVO
  def initialize args
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  attr_reader :country, :avg_score, :total_bottles, :avg_price

  def to_s
    [country, total_bottles, avg_price, avg_score].join(', ')
  end
end