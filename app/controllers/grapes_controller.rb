class GrapesController < ApplicationController
  def search
    if params[:term]
      grapes = Grape.search_by_name params[:term]
    else
      grapes = Grape.find(:all, :order => 'name asc')
    end

    render :json => grapes.map { |w| w.name }
  end
end
