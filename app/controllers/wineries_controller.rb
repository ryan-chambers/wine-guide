class WineriesController < ApplicationController
  def search
    wineries = Winery.search_by_name params[:term]

    render :json => wineries.map { |w| w.name }
  end
end