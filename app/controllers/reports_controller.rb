class ReportsController < ApplicationController
  def cellar
    @wines = Wine.find_wines_in_cellar
  end
end
