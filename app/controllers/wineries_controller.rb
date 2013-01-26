# encoding: utf-8
class WineriesController < ApplicationController
  def search
    if params[:term]
      like= "%".concat(params[:term].downcase.concat("%"))
      wineries = Winery.where("name like ?", like).order('name asc')
    else
      wineries = Winery.find(:all, :order => 'name asc')
    end
    list = wineries.map { |w| w.name }

    respond_to do |format|
      format.html
      format.json { render :json => list}
    end
  end
end