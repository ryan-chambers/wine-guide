class GrapesController < ApplicationController
  def search
    if params[:term]
      grapes = Grape.search_by_name params[:term]
    else
      grapes = Grape.findAll
    end

    if params[:detailed]
      render :json => grapes.map { |g| { :name => g.name, :id => g.id } }
    else
      render :json => grapes.map { |g| g.name}
    end
  end
end
