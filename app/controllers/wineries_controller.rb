# encoding: utf-8
class WineriesController < ApplicationController
  def search
    if params[:term]
      like= "%".concat(params[:term].downcase.concat("%"))
      wineries = Winery.where("name like ?", like).order('name asc')
    else
      wineries = Winery.all.order('name desc')
    end
    list = wineries.map { |w| w.name }
    render json: list
  end
end
