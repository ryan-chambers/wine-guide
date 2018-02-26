class WineriesController < ApplicationController
  def search
    wineries = Winery.search_by_name params[:term]

    render :json => wineries.map { |w| w.name }
  end

  def show
    @winery = Winery.includes(:wines, wines: [:bottles, :grapes]).find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end
end
