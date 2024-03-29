require 'report_vo'

class Bottle < ActiveRecord::Base
  FRIDGE = 'Fridge'
  CELLAR = 'Cellar'

  attr_reader :review_day_of_year

  validate :score_between_0_and_100, :score_not_null_unless_in_fridge, :comments_not_null_unless_in_fridge, :reviewdate_not_null_unless_in_fridge, :drink_from_before_drink_to 

  validates :price, :presence => true

  belongs_to :wine

  after_initialize :init

  def can_tweet
    ! in_fridge
  end

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

  def self.generate_yearly_report
    year_range = Bottle.minimum(:reviewdate).year .. Time.new.year
    year_range.map { |y|
      generate_summary_for_year y 
    }
  end

  def self.generate_summary_for_year(year)
    y = year.to_s
    Bottle.find_by_sql("select count(score) as total_bottles,
       sum(price) as amount_spent,
       avg(score) as avg_score,
       avg(price) as avg_price
       from bottles bottles
       where reviewdate >= '" + y + "-01-01' and reviewdate <= '" + y + "-12-31'").collect { |s|
        YearReportVO.new :year => year, 
          :amount_spent => Float(s[:amount_spent] || 0),
          :avg_score => Float(s[:avg_score] || 0), 
          :total_bottles => Integer(s[:total_bottles] || 0), 
          :avg_price => Float(s[:avg_price] || 0)
    }[0]
  end

  def self.generate_score_breakdown_report
    Bottle.find_by_sql("select score, count(score) as score_count
      from bottles
      group by score
      having score >= 1
      order by score asc").collect { |s|
        ScoreBreakdownReportVO.new :score => Integer(s[:score]), :score_count => Integer(s[:score_count])
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
#    p "review date #{reviewdate}, in fridge #{in_fridge}"
    errors.add(:reviewdate, "is missing.") if reviewdate.nil? and ! in_fridge
    errors.add(:reviewdate, "can't be populated if wine is in fridge.") if ! reviewdate.nil? and in_fridge
  end

  def score_between_0_and_100
    errors.add(:score, "must be between 0 and 100.") if ! in_fridge and (score.nil? || score > 100 || score < 0)
  end

  def drink_from_before_drink_to
#    p "drink_from is #{drink_from} and drink_to is #{drink_to}"
    errors.add(:drink_from, "must be after drink to") if drink_from and drink_to and (drink_from.to_i > drink_to.to_i)
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

  def to_tweet
    parts = [wine.winery.name, wine.other, wine.year.to_s + '.', comments + '.', score.to_i.to_s + "/100", "$" + price.to_s]
    tweet = parts.reduce([]) { |out, next_part|
#      p "Adding #{next_part} to #{out}"
      if ! next_part.nil?
        tweet_length = out.join(' ').length + next_part.length + 1
        if tweet_length <= 140
          out << next_part
        end
      end
#      p "Got #{out}"
      out
    }
    tweet.join(' ')
  end  

  def recommended_storage
    if in_fridge
      if price > 25 and drink_to and drink_to > Date.today.year + 2
        CELLAR
      else
        FRIDGE
      end
    else
      'none'
    end
  end
end

class YearReportVO < ReportVO
  attr_reader :year, :amount_spent, :avg_score, :total_bottles, :avg_price
  
  def to_s
    [year, amount_spent, avg_score, total_bottles, avg_price].join(', ')
  end
end

class CountryReportVO < ReportVO
  attr_reader :country, :avg_score, :total_bottles, :avg_price

  def to_s
    [country, total_bottles, avg_price, avg_score].join(', ')
  end
end

class ScoreBreakdownReportVO < ReportVO
  attr_reader :score, :score_count

  def to_s
    [score, score_count].join(', ')
  end
end
