class WinesController < ApplicationController
  def index
    # FIXME add pagination
    @wines = Wine.limit(50)

    respond_to do |format|
      format.html
      format.json { render :json => @wines}
    end
  end

  def show
    @wine = Wine.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end
end
