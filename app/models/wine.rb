class Wine < ActiveRecord::Base
  attr_accessible :country, :drink_from, :drink_until, :in_cellar, :lcbo_code, :other, :purchased_date, :region, :winery_id, :year, :grapes

  validate :year_after_1800

  validates :winery, :year, :grapes, :country, :presence => true

  belongs_to :winery

  has_many :scores

  def year_after_1800
    errors.add(:year, "The year must be after 1800") if
      year < 1800
  end
end
