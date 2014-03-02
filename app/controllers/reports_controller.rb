class ReportsController < ApplicationController
  include ReportsHelper

  def cellar
    if params[:term] == 'soon'
      @wines = Wine.find_in_cellar_ready_to_drink
    else
      @wines = Wine.find_in_cellar
    end
  end

  def maturity_profile
    wines = Wine.find_in_cellar

    year_range = determine_years(wines)
    @labels = year_range.join(',')
    num_bottles = determine_bottles_per_year(year_range, wines)
#    p "#{num_bottles}"
    @bottles = num_bottles.join(',')
  end

  def score_breakdown
    score_breakdowns = Bottle.generate_score_breakdown_report
    @scores = score_breakdowns.map { | s | s.score }.join(', ')
    @score_counts = score_breakdowns.map { | s | s.score_count }.join(', ')
  end

  def country
    @country_summaries = Bottle.generate_country_report
  end

  def this_day_in_wine
    @wines = Wine.find_drank_this_day
  end

  def favourite_wines
    @wines = Wine.find_favourites params[:score_filter]
  end
end
