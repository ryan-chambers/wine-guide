# encoding: utf-8
class WineriesController < ApplicationController
  def search
    if params[:term]
      like= "%".concat(params[:term].downcase.concat("%"))
      wineries = Winery.where("name like ?", like).order('name asc')
    else
      wineries = Winery.find(:all, :order => 'name asc')
    end
    
    render :json => wineries.map { |w| w.name }
  end
end