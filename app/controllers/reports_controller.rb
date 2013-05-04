class ReportsController < ApplicationController
  def cellar
    if params[:term] == 'soon'
      @wines = Wine.find_wines_in_cellar_ready_to_drink
    else
      @wines = Wine.find_wines_in_cellar
    end
  end
end
