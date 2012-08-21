class Wine < ActiveRecord::Base
  attr_accessible :country, :drink_from, :drink_until, :in_cellar, :lcbo_code, :other, :purchased_date,
    :region, :winery_id, :year

  validate :year_after_1800

  validates :winery, :year, :country, :presence => true

  belongs_to :winery

  has_many :wine_grapes
  has_many :scores

  def year_after_1800
    if(@year)
      errors.add(:year, "The year must be after 1800") if
        @year < 1800
    end
  end

  def to_s
    _other = @other.empty? ? '' : other.join(', ')
    _grapes = @wine_grapes.empty? ? '' : @wine_grapes.join(', ')
    [@winery_name, _other, @region, @year, _grapes, @lcbo, @scores.to_s].join(', ')
  end
end
