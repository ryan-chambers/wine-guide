class Score < ActiveRecord::Base
  validate :score_between_0_and_100

  belongs_to :wine

  def score_between_0_and_100
    errors.add(:score, "The score must be between 0 and 100") if
      score > 100 || score < 0
  end

  # FIXME - add setter that hides implementation details for Date
end
