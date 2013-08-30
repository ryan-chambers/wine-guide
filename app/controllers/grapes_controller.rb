class GrapesController < ApplicationController
  def search
    if params[:term]
      grapes = Grape.search_by_name params[:term]
    else
      grapes = Grape.findAll
    end

    render :json => grapes.map { |w| w.name }
  end
end
