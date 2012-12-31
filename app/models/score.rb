class Score < ActiveRecord::Base
  attr_accessible :reviewdate, :score, :comments, :price, :wine, :to, :from, :in_fridge

  validate :score_between_0_and_100

  belongs_to :wine

  def score_between_0_and_100
    errors.add(:score, "The score must be between 0 and 100") if
      score > 100 || score < 0
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
      ''
    else
      score.ceil.to_s
    end
  end

  def to_s
    [comments, score, reviewdate, price, to, from, in_fridge].join(', ')
  end
  # FIXME - add setter that hides implementation details for Date
end
