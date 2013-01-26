# encoding: utf-8
class WineriesController < ApplicationController
  def search
    if params[:term]
      wineries = Winery.search_by_name params[:term]
    else
      wineries = Winery.find(:all, :order => 'name asc')
    end
    
    render :json => wineries.map { |w| w.name }
  end
end