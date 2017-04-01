class BottlesController < ApplicationController
  before_action :authenticate, :except => [:index, :show]

  def index
    @bottles = Bottle.all

    respond_to do |format|
      format.html
      format.json { render :json => @bottles}
    end
  end

  def show
    @bottle = Bottle.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end

  def create
   @wine = Wine.find(params[:wine_id])
   @bottle = @wine.bottles.create(bottle_params) do |bottle|
      if bottle.in_fridge
        bottle.score = 0
      end
    end

    if @bottle.errors.any?
      flash[:alert] = @bottle.errors.full_messages
    end

    redirect_to wine_path(@wine)
  end

  def edit
    @bottle = Bottle.find(params[:id])
  end

  def update
    @bottle = Bottle.find(params[:id])

    respond_to do |format|
      if @bottle.update_attributes(bottle_params)
        format.html  { redirect_to(@bottle,
                      :notice => 'Bottle was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "show" }
        format.json  { render :json => @bottle.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

  private

  def bottle_params
    params.require(:bottle).permit(:reviewdate, :score, :comments, :price, :drink_to, :drink_from, :in_fridge, :bought)
  end
end
