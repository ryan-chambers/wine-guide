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
    @average = calculate_average @country_summaries
  end

  def calculate_average(summaries)
    @bottles = 0
    @score = 0
    @price = 0

    summaries.map { |s| 
      @bottles += s.total_bottles
      @score += s.avg_score * s.total_bottles
      @price += s.avg_price * s.total_bottles
    }

    AverageVO.new :total_bottles => @bottles, :avg_score => (@score / @bottles), :avg_price => @price / @bottles
  end

  class AverageVO
    attr_reader :avg_score, :total_bottles, :avg_price    

    def initialize args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end

  def yearly
    @yearly_summaries = Bottle.generate_yearly_report
  end

  def this_day_in_wine
    @wines = Wine.find_drank_this_day
  end

  def favourite_wines
    @wines = Wine.find_favourites params[:score_filter]
  end
end
