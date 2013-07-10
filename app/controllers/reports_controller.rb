class ReportsController < ApplicationController
  def cellar
    if params[:term] == 'soon'
      @wines = Wine.find_in_cellar_ready_to_drink
    else
      @wines = Wine.find_in_cellar
    end
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
